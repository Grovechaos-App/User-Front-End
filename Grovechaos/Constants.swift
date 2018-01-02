//
//  Constants.swift
//  Grovechaos
//
//  Created by Hayne Park on 12/25/17.
//  Copyright © 2017 Alexander Bui. All rights reserved.
//

import Foundation

/* TODO: Try struct format for constants */
struct Constants {
    
    // MARK: Grovechaos API
    struct GrovechaosAPI {
        static let APIBaseURL = "localhost:8080"
    }
    
    // MARK: Grovechaos Parameter Keys
    struct GrovechaosParamterKeys {
        static let georadius = "georadius"
    }
    
    // MARK: Google Disstance Matrix API
    struct GoogleMapsDistanceMatrixAPI {
        static let APIBaseURL = "https://maps.googleapis.com/maps/api/distancematrix/json"
    }
    
    // MARK: Google Parameter Keys
    struct DistanceMatrixParameterKeys {
        static let units = "units"
        static let origins = "origins"
        static let destinations = "destinations"
        static let key = "key"
        static let fmt = "fmt"
        static let mode = "mode"
    }
    
    // MARK: Google Parameter Values
    struct DistanceMatrixParameterValues {
        static let key = "AIzaSyDVtv42xkDdc8PlBeL2zWcznKodZ2LMpF0"
        static let imperial = "imperial"
        static let driving = "driving"
        static let bicycling = "bicycling"
    }
    
}
