//
//  HuntMapViewController.swift
//  Scav
//
//  Created by Chloe Gottlieb on 7/11/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HuntMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    static func create() -> HuntMapViewController {
        return HuntMapViewController(nibName: String(describing: self.self), bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsUserLocation = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startUpdatingLocation()
    }

    
    private func presentUserLocationAuthorizationAlert() {
        let alertController = UIAlertController(title: "SCAV wants to access your location", message: "When prompted, please enable location services in order to complete scavenger hunts.\nHappy hunting!", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "I don't like fun.", style: .cancel)
        
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Let's play!", style: .default) { [weak self] _ in
            self?.locationManager.requestWhenInUseAuthorization()
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
        
    }
 
    private func startUpdatingLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            presentUserLocationAuthorizationAlert()
        default:
            ()
        }
    }
}


extension HuntMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView?.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}

//As of time of writing, I am offline on the train and do not want to forget my idea so I decided to add it here as a comment. The function locationManager.requestLocation() works on iOS 9+ and is a one-time request of the user's location. We can implement this when the user presses the "Am I here?" button. The kogic can read something like
//if amIHereButton == true {
    //locationManager.requestLoation()
//}
//or something to this extent
