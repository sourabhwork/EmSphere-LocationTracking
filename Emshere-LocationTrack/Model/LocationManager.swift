//
//  LocationManager.swift
//  emSphere
//
//  Created by Dhiraj Chaudhari on 23/05/18.
//  Copyright © 2018 Dhiraj Chaudhari. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: NSError)
}

class LocationManager: NSObject, CLLocationManagerDelegate {

    class var sharedInstance: LocationManager {
        let sharedInstance = LocationManager()
        return sharedInstance
    }

    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    var delegate: LocationServiceDelegate?

    override init() {
        super.init()

        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }

        if CLLocationManager.authorizationStatus() == .notDetermined {
            // you have 2 choice
            // 1. requestAlwaysAuthorization
            // 2. requestWhenInUseAuthorization
            locationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .restricted {
            locationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .denied {
            locationManager.requestWhenInUseAuthorization()
        }

        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation // The accuracy of the location data
        locationManager.distanceFilter = 10 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        locationManager.delegate = self
    }

    func startUpdatingLocation() {
        print("Starting Location Updates in startUpdatingLocation func ")
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // you have 2 choice
            // 1. requestAlwaysAuthorization
            // 2. requestWhenInUseAuthorization
            locationManager?.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .restricted {
            locationManager?.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .denied {
            locationManager?.requestWhenInUseAuthorization()
        }
        self.locationManager?.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }

    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else {
            return
        }
        // singleton for get last location
        self.lastLocation = location

        print("Actually get location cpordinate in Location Manager =",location)
        // use for real time update location
        updateLocation(currentLocation: location)
        if (UserProfile.getIshideMarkAttendance() == "1") {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "GetLocationMap"), object: nil)
        }else {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "GetLocation"), object: nil)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

        // do on error
        updateLocationDidFailWithError(error: error as NSError)
    }

    // Private function
    private func updateLocation(currentLocation: CLLocation){

        guard let delegate = self.delegate else {
            return
        }

        delegate.tracingLocation(currentLocation: currentLocation)
    }

    private func updateLocationDidFailWithError(error: NSError) {

        guard let delegate = self.delegate else {
            return
        }

        delegate.tracingLocationDidFailWithError(error: error)
    }

    func getAddress() -> String? {
        
        if !Connectivity.isConnectedToInternet() {
            return ""
        }

        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lastLocation!.coordinate.latitude
        center.longitude = lastLocation!.coordinate.longitude

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

        var addressString : String = ""
        ceo.reverseGeocodeLocation(loc, completionHandler: {(placemarks, error) in
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
                }

        })
        return addressString
    }

    func enableLocationService()-> Bool {
        let status = CLLocationManager.authorizationStatus()
        var result = true
        switch status {
        case .restricted, .denied:
            // Disable your app's location features
            print("location service is off denied,restricted")
            result = false

            break
        case .notDetermined:
            print("location service is off notDetermined")
            result = false
        case .authorizedAlways:
            print("location service is off authorizedAlways")
        case .authorizedWhenInUse:
            print("location service is off authorizedWhenInUse")
        }
        return result
    }

    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {   switch status {
    case .restricted, .denied:
        // Disable your app's location features
        self.locationManager?.requestAlwaysAuthorization()
        break

    case .authorizedWhenInUse:
        // Enable only your app's when-in-use features.
        self.locationManager?.requestWhenInUseAuthorization()
        break

    case .authorizedAlways:
        // Enable any of your app's location services.
       self.locationManager?.requestAlwaysAuthorization()
        break

    case .notDetermined:
        self.locationManager?.requestAlwaysAuthorization()
        break
        }
    }
}

