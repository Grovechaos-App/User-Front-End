//
//  LocationServicesViewController.swift
//  Grovechaos
//
//  Created by Hayne Park on 12/27/17.
//  Copyright © 2017 Alexander Bui. All rights reserved.
//

import UIKit
import CoreLocation

class LocationServicesViewController: UIViewController {

    @IBOutlet weak var manualOptionButton: UIButton!
    
    @IBAction func didPressAutomaticOptionButton(_ sender: Any) {
        guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manualOptionButton.layer.borderWidth = 1
        manualOptionButton.layer.borderColor = UIColor.black.cgColor
        
        // Observe when app comes from background
        NotificationCenter.default.addObserver(self, selector:#selector(checkLocationServiceStatus), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)

    }
    
    @objc func checkLocationServiceStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            dismiss(animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
