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
    
    static var lastLocation = CLLocationCoordinate2D()
    
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
            print("😎A new visits to 😎\(result.data)")
        }
    }
    
    class func getgGPSLocation(coordinate: @escaping(CLLocationCoordinate2D)->Void) {
        print("&&&&&&&&&&&&&&&&&&&&&&&&")
        SwiftLocation.gpsLocation().then {
            print("😁Location is 😁",$0.location)
            coordinate($0.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
        }
    }
    
//    class func getDetailsOfLocation(coordinate: @escaping(CLLocationCoordinate2D)->Void) {
    class func getDetailsOfLocation() {
        SwiftLocation.gpsLocationWith {
            // configure everything about your request
            $0.subscription = .continous // continous updated until you stop it
            $0.accuracy = .city
            $0.minDistance = 1 // updated every 300mts or more
            $0.minTimeInterval = 1 // updated each 30 seconds or more
            $0.activityType = .automotiveNavigation
            //$0.timeout = .delayed(5) // 5 seconds of timeout after auth granted
        }.then { result in // you can attach one or more subscriptions via `then`.
            switch result {
            case .success(let newData):
                self.lastLocation = newData.coordinate
                //coordinate(newData.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
            case .failure(let error):
                print("An error has occurred: \(error.localizedDescription)")
            }
        }
    }
    
    class func getAddressWithGoogle(coordinate: CLLocationCoordinate2D, address: @escaping(String)->Void){
        
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
                address(addressString)
                //completionHandler(addressString,error)
                print("my address=",addressString)
                // self.currentAddress = addressString
            }
            
        })
        
    }
}



