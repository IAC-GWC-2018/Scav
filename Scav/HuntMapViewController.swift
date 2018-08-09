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
import PopupDialog

class HuntMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    private var gameTracker: HuntGameTracker?
    
    static func create(hunt: Hunt) -> HuntMapViewController {
        let vc = HuntMapViewController(nibName: String(describing: self.self), bundle: nil)
        vc.gameTracker = HuntGameTracker(hunt: hunt)
        vc.gameTracker?.delegate = vc
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsUserLocation = true
        configureBackButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startUpdatingLocation()
    }
    
    private func configureBackButton() {
        navigationController?.navigationItem.backBarButtonItem = nil
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
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let title = "You're about to exit your scavenger hunt. Are you sure you want to that?"
        let message = "Please note: once you exit the hunt, all your progress will be lost."
        let popup = PopupDialog(title: title, message: message, tapGestureDismissal: false)
        
        let okayButton = DefaultButton(title: "End scavenger hunt and lose progress") { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        let cancelButton = DefaultButton(title: "Continue scavenger hunt", action: nil)
        
        popup.addButtons([okayButton, cancelButton])
        
        // Present dialog
        present(popup, animated: true, completion: nil)
        
    }
    
    @IBAction func huntButtonPressed(_ sender: Any) {
        guard let hint = gameTracker?.currentHint else {
            return
        }
        
        present(hint: hint)
    }
    
    private func present(hint: Hint) {
        
        enum HintPresentation {
            case previous
            case next
        }
        
        func updateHint(_ type: HintPresentation, popup: PopupDialog) {
            var hint: Hint?
            switch type {
            case .previous:
                hint = gameTracker?.previousHint()
            case .next:
                hint = gameTracker?.nextHint()
            }
            
            if let hint = hint {
                let vc = popup.viewController as? PopupDialogDefaultViewController
                
                vc?.titleText = hint.description
            }
        }
        
        
        let popup = PopupDialog(title: hint.description, message: "", tapGestureDismissal: false)

        let okayButton = CancelButton(title: "Okay", action: nil)
     
        let nextHintButton = DefaultButton(title: "Next Hint", dismissOnTap: false) {
            updateHint(.next, popup: popup)
        }

        let previousHintButton = DefaultButton(title: "Previous Hint", dismissOnTap: false) {
            updateHint(.previous, popup: popup)
        }
        
        popup.addButtons([okayButton, nextHintButton, previousHintButton])
        
        // Present dialog
        present(popup, animated: true, completion: nil)
    }
}

extension HuntMapViewController: HuntGameTrackerDelegate {
    func didComplete(hunt: Hunt) {
        let vc = CompletedHuntViewController.create(hunt: hunt)
        present(vc, animated: true, completion: nil)
    }
    
    func didFind(destination: Destination) {
        let popup = PopupDialog(title: "You found the destination!" , message: destination.title)
        
        let button = DefaultButton(title: "Next Destination", action: nil)
        
        popup.addButtons([button])
        
        self.present(popup, animated: true, completion: nil)
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
        
        gameTracker?.update(userLocation: location)
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView?.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}
