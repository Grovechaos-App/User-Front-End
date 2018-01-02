//
//  SearchViewController.swift
//  Grovechaos
//
//  Created by Hayne Park on 12/5/17.
//  Copyright © 2017 Alexander Bui. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SearchViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    // Did select origin tag/count
    var didSelectOriginCount = 0
    
    // Selected Origin
    var originTitle = ""
    var originCoordinate = CLLocationCoordinate2D()
    
    // Selected Destination
    var destinationTitle = ""
    var destinationCoordinate = CLLocationCoordinate2D()
    
    // Address autocomplete
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    // Location services
    var locationManager = CLLocationManager()
    
    // deint observer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func didTouchDownBackButton(_ sender: Any) {
        backButton.imageView?.image = backButton.imageView?.image!.withRenderingMode(.alwaysTemplate)
        backButton.imageView?.tintColor = UIColor.gray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topView.addBorder(side: .bottom, thickness: 1, color: .darkGray)
        // Do any additional setup after loading the view.
        
        // Delegates and datasorce
        locationManager.delegate = self
        originTextField.delegate = self
        destinationTextField.delegate = self
        searchCompleter.delegate = self
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        
        // Change appearance of textFields
        originTextField.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        destinationTextField.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        originTextField.layer.borderWidth = 1
        destinationTextField.layer.borderWidth = 1
        destinationTextField.layer.cornerRadius = 1
        originTextField.layer.cornerRadius = 1

        let firstLaunchKey = UserDefaults.standard.bool(forKey: "firstLaunch")

        if CLLocationManager.authorizationStatus() == .notDetermined || CLLocationManager.authorizationStatus() == .denied {
            if firstLaunchKey == false {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "locationServicesViewController") as! LocationServicesViewController
                self.present(vc, animated: true, completion: {
                })
            } else {
                // Set persistant bool to determine if first launch
                UserDefaults.standard.set(false, forKey: "firstLaunch")
                locationManager.requestWhenInUseAuthorization()
                locationManager.distanceFilter = kCLDistanceFilterNone
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }
        }
        
        // Setup keyboard adjustment

        // Observe when app comes from background
        NotificationCenter.default.addObserver(self, selector:#selector(checkLocationServiceStatus), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        // Observe when keyboard appears
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // Add targets to call function when textFields are being edited
        originTextField.addTarget(self, action: #selector(originTextFieldDidChange(_:)), for: .editingChanged)
        destinationTextField.addTarget(self, action: #selector(destinationTextFieldDidChange(_:)), for: .editingChanged)
    }

    @objc func checkLocationServiceStatus() {
        if CLLocationManager.authorizationStatus() == .denied {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "locationServicesViewController") as! LocationServicesViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if CLLocationManager.authorizationStatus() == .denied {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "locationServicesViewController") as! LocationServicesViewController
            self.present(vc, animated: true, completion: nil)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locationArray = locations as NSArray
        var locationObj = locationArray.lastObject as! CLLocation
        var coord = locationObj.coordinate
        print(coord.latitude)
        print(coord.longitude)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text != "" {
            //do something if it's not empty
            searchCompleter.queryFragment = textField.text!
            print(textField.text!)
        } else {
            searchCompleter.queryFragment = " "
        }
        // Change textField background color depending if active to make it easier to see
        if originTextField.isEditing == true {
            destinationTextField.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            originTextField.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            destinationTextField.layer.borderColor = UIColor.lightGray.cgColor
            originTextField.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        originTextField.text = originTitle
        destinationTextField.text = destinationTitle
    }
    @objc func originTextFieldDidChange(_ textField: UITextField) {
        // check for empty string
        
        if textField.text != "" {
            //do something if it's not empty
            searchCompleter.queryFragment = textField.text!
            print(textField.text!)
        } else {
            searchCompleter.queryFragment = " "
        }
        if didSelectOriginCount != 0 {
            didSelectOriginCount -= 1
        }
    }
    
    @objc func destinationTextFieldDidChange(_ textField: UITextField) {
        // check for empty string
        
        if textField.text != "" {
            //do something if it's not empty
            searchCompleter.queryFragment = textField.text!
            print(textField.text!)
        } else {
            searchCompleter.queryFragment = " "
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            searchResultsTableView.contentInset = UIEdgeInsets.zero
        } else {
            searchResultsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        searchResultsTableView.scrollIndicatorInsets = searchResultsTableView.contentInset
    }
}

extension SearchViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let completion = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearchRequest(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            let coordinate = response?.mapItems[0].placemark.coordinate
            print(String(describing: coordinate))
        }
        if originTextField.isEditing == true {
            originTitle = completion.title
            originTextField.text = completion.title
            destinationTextField.becomeFirstResponder()
            if didSelectOriginCount == 0 {
                didSelectOriginCount += 1
            }
            let search = MKLocalSearch(request: searchRequest)
            search.start { (response, error) in
                let coordinate = response?.mapItems[0].placemark.coordinate
                self.originCoordinate = coordinate!
            }
        } else {
            destinationTitle = completion.title
            destinationTextField.text =  completion.title
            let search = MKLocalSearch(request: searchRequest)
            search.start { (response, error) in
                let coordinate = response?.mapItems[0].placemark.coordinate
                self.destinationCoordinate = coordinate!
            }
            if didSelectOriginCount == 1 || !originTitle.isEmpty && !destinationTitle.isEmpty {
                print("it works \(originTitle), \(originCoordinate)")
                print("it works \(destinationTitle), \(destinationCoordinate)")
            }
        }
    }
}
