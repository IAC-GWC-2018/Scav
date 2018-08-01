//
//  HuntLocationViewController.swift
//  Scav
//
//  Created by Groisman, Margarita on 7/27/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit
import MapKit

class HuntLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    static func create() -> HuntLocationViewController {
        return HuntLocationViewController(nibName: String(describing: self.self), bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let press = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        mapView.addGestureRecognizer(press)
    }
    
    @objc func handleLongPress (gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint: CGPoint = gestureRecognizer.location(in: mapView)
            let newCoordinate: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            addAnnotationOnLocation(pointedCoordinate: newCoordinate)
        }
    }
    
    func addAnnotationOnLocation(pointedCoordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = pointedCoordinate
        annotation.title = "Location"
        mapView.addAnnotation(annotation)
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
