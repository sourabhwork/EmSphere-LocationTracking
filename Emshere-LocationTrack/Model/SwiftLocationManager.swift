//
//  SwiftLocationManager.swift
//  Emshere-LocationTrack
//
//  Created by Sourabh Kumbhar on 26/07/21.
//  Copyright © 2021 Dhiraj Chaudhari. All rights reserved.
//

import Foundation
import SwiftLocation
import CoreLocation
import GoogleMaps

class SwiftLocationManager {
    
    class func initilizeSwiftLocation() {
        SwiftLocation.allowsBackgroundLocationUpdates = true
        SwiftLocation.requestAuthorization(.onlyInUse) { newStatus in
            print("New status == \(newStatus.description)")
        }
        SwiftLocation.visits(activityType: .fitness).then { result in
            print("A new visits to \(result.data)")
        }
    }
        
    
    class func getIsAuthorization()->Bool {
        var result = false
        switch SwiftLocation.authorizationStatus {
        case .authorizedAlways:
            result = true
        case .authorizedWhenInUse:
            result = true
        case .denied:
            result = false
        case .notDetermined:
            result = false
        case .restricted:
            result = false
        @unknown default:
            break
        }
        return result
    }
    
    class func getAddress(location: CLLocationCoordinate2D)->GeoLocation? {
        var geoLocation: GeoLocation?
        let service = Geocoder.Apple(coordinates: location)
        SwiftLocation.geocodeWith(service).then { result in
            // You will get an array of suggested [GeoLocation] objects with data and coordinates
            geoLocation = result.data?.first
        }
        return geoLocation
    }
    
    class func lastKnownLocation()->CLLocation {
        return SwiftLocation.lastKnownGPSLocation ?? CLLocation(latitude: 0.0, longitude: 0.0)
    }
    
    class func getVisitLocation() {
        SwiftLocation.visits(activityType: .fitness).then { result in
            print("A new visits to \(result.data)")
        }
    }
    
    class func getgGPSLocation() {
        print("&&&&&&&&&&&&&&&&&&&&&&&&")
        SwiftLocation.gpsLocation().then{
            print("Location is ",$0.location)
        }
    }
    
    class func getAddressWithGoogle(coordinate: CLLocationCoordinate2D){
        
        if !Connectivity.isConnectedToInternet() {
            return
        }
                
        let clGeocoder: CLGeocoder = CLGeocoder()
        let loc: CLLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        var addressString : String = ""
        clGeocoder.reverseGeocodeLocation(loc, completionHandler: {(placemarks, error) in
            if (error != nil) {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                //completionHandler(addressString,error)
                print("my address=",addressString)
                // self.currentAddress = addressString
            }
            
        })
        
    }
}



