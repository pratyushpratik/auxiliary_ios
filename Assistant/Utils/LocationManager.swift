//
//  LocationManager.swift
//
//  Created by Pratyush Pratik on 01/02/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

//Mark:- modules
import Foundation
import CoreLocation
import UIKit

protocol LocationUpdateDelegate : class{
    func locationDidUpdate(toLocation location : CLLocationCoordinate2D?)
}

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    static let shared : LocationManager = {
        let instance = LocationManager()
        return instance
    }()
    
    var isContinuousLocationUpdate = false
    private var locationSendCounter = 0
    private var locationManager = CLLocationManager()
    
    private var currentLocation2d : CLLocationCoordinate2D? {
        didSet {
            if self.isContinuousLocationUpdate || locationSendCounter == 0 {
                DispatchQueue.global().async {
                    if let currentDelegate = self.delegate {
                        self.locationSendCounter += 1
                        //LocalStore.currentLocationLatitude = self.currentLocation2d?.latitude
                        //LocalStore.currentLocationLongitude = self.currentLocation2d?.longitude
                        currentDelegate.locationDidUpdate(toLocation : self.currentLocation2d)
                    }
                }
            }
        }
    }
    weak var delegate : LocationUpdateDelegate?
    
    func stopUpdating() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func startUpdating() {
        self.isContinuousLocationUpdate = false
        self.locationSendCounter = 0
        self.locationManager.startUpdatingLocation()
    }
    
    var accuracy : CLLocationAccuracy {
        get {
            return self.locationManager.desiredAccuracy
        }
        set {
            self.locationManager.desiredAccuracy = newValue
        }
    }
    
    override private init () {
        
        super.init()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let validLocation = manager.location else { return }
        self.currentLocation2d = validLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            break
        default:
            break
        }
    }
    
    var isLocationActive : Bool {
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            }
        } else {
            return false
        }
    }
    
    func showEnableLocationPopup(vcToShow : UIViewController) -> Bool {
        
        if !isLocationActive {
            Alert().showWithCancelAndOk(title: "enableLocation".localized, okTitle: "settings".localized, cancelTitle: "cancel".localized, message: "pleaseSelectAlwaysMode".localized, viewController: vcToShow, okAction: {
                
                guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, completionHandler: { (isCompleted) in
                    })
                } else {
                    UIApplication.shared.openURL(url)
                }
            })
            return false
        }
        return true
    }
}
