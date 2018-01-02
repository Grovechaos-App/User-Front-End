//
//  Networking.swift
//  Grovechaos
//
//  Created by Hayne Park on 12/25/17.
//  Copyright © 2017 Alexander Bui. All rights reserved.
//

import Foundation

class Networking : NSObject {
    
    // Grovechaos API
    func getNearbyDrivers(longitude: String, latitude: String, completionHandler: @escaping (_ success: Bool?, _ error: Error?) -> Void) {
        let methodParameters = [
            Constants.DistanceMatrixParameterKeys.origins: longitude,
            Constants.DistanceMatrixParameterKeys.destinations: latitude
        ]
        
        let urlString = Constants.GrovechaosAPI.APIBaseURL + escapedParameters(methodParameters as [String:AnyObject])
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // no error, woohoo!
            if error == nil {
                
                // there was data returned
                if let data = data {
                    
                    let parsedResult: [String:AnyObject]!
                    do {
                        parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
                    } catch {
                        print("Could not parse the data as JSON: '\(data)'")
                        return
                    }
                    
                    if let jsonDictionary = parsedResult["nearybyDrivers"] as? [[String:AnyObject]] {
                        /*for jsonObject in jsonDictionary {
                            let elements = jsonObject["elements"] as! String
                            // let collectionName = jsonObject["collectionName"] as? String
                            // let artistName = jsonObject["artistName"] as! String
                            // let trackName = jsonObject["trackName"] as! String
                            
                            //appleObjects.append(AppleObject(trackName: trackName, artistName: artistName, albumName: collectionName, albumImage: artwork))
                            print(elements)
                            
                        }*/
                        print("what what \(parsedResult)")
                        completionHandler(true, nil)
                    }
                }
            }
        }
        
        // start the task!
        task.resume()
    }
    
    // Google API
    func getGoogleDistanceMatrix(origins: String, destinations: String, completionHandler: @escaping (_ success: Bool?, _ error: NSError?) -> Void) {
        
        // [creating the url and request]...
        let methodParameters = [
            Constants.DistanceMatrixParameterKeys.units: Constants.DistanceMatrixParameterValues.imperial,
            Constants.DistanceMatrixParameterKeys.origins: origins,
            Constants.DistanceMatrixParameterKeys.destinations: destinations,
            Constants.DistanceMatrixParameterKeys.mode: Constants.DistanceMatrixParameterValues.driving
        ]
        
        let urlString = Constants.GoogleMapsDistanceMatrixAPI.APIBaseURL + escapedParameters(methodParameters as [String:AnyObject])
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // no error, woohoo!
            if error == nil {
                
                // there was data returned
                if let data = data {
                    
                    let parsedResult: [String:AnyObject]!
                    do {
                        parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
                    } catch {
                        print("Could not parse the data as JSON: '\(data)'")
                        return
                    }
                    
                    if let jsonDictionary = parsedResult["rows"] as? [[String:AnyObject]] {
                        for jsonObject in jsonDictionary {
                            let elements = jsonObject["elements"] as! String
                           // let collectionName = jsonObject["collectionName"] as? String
                           // let artistName = jsonObject["artistName"] as! String
                           // let trackName = jsonObject["trackName"] as! String
                            
                            //appleObjects.append(AppleObject(trackName: trackName, artistName: artistName, albumName: collectionName, albumImage: artwork))
                            print(elements)
                            
                        }
                        completionHandler(true, nil)
                    }
                }
            }
        }
        
        // start the task!
        task.resume()
    }
    
    private func escapedParameters(_ parameters: [String:AnyObject]) -> String {
        
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            
            for (key, value) in parameters {
                
                // make sure that it is a string value
                let stringValue = "\(value)"
                
                // escape it
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                // append it
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
                
            }
            
            return "?\(keyValuePairs.joined(separator: "&"))"
        }
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> Networking {
        struct Singleton {
            static var sharedInstance = Networking()
        }
        return Singleton.sharedInstance
    }
}
