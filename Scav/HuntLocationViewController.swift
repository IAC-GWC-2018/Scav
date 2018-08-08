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
    var annotation = MKPointAnnotation()
    
    @IBOutlet weak var locationTitleTextField: UITextField!
    
    @IBOutlet weak var hintTextField: UITextField!
    
    @IBOutlet weak var addHintButton: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBAction func hintButtonTapped(_ sender:
        UIButton) {
        addHint()
    }
    
    
    private func addHint() {
        if let hintText = hintTextField.text {
            hints.append(hintText)
            let hintLabel = UILabel()
            hintLabel.text = hintText
            stackView.addArrangedSubview(hintLabel)
        }
    }
    
    static func create() -> HuntLocationViewController {
        return HuntLocationViewController(nibName: String(describing: self.self), bundle: nil)
    }
    
    private var selectedLocation: Location?
    private var locationTitle: String? {
        return locationTitleTextField.text
    }
    
    private var hints = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let press = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        mapView.addGestureRecognizer(press)
    }
    
    @objc func handleLongPress (gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint: CGPoint = gestureRecognizer.location(in: mapView)
            let currentCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            addAnnotationOnLocation(pointedCoordinate: currentCoordinate)
        }
    }
    
    func addAnnotationOnLocation(pointedCoordinate: CLLocationCoordinate2D) {
        annotation.coordinate = pointedCoordinate
        annotation.title = "Location"
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func back (_ sender:
        UIButton) {
        self.dismiss(animated: true, completion: nil)
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
