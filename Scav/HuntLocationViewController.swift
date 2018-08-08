//
//  HuntLocationViewController.swift
//  Scav
//
//  Created by Groisman, Margarita on 7/27/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit
import MapKit

protocol AddHuntDestinationDelegate: class {
    func add(destination: Destination)
}

class HuntLocationViewController: UIViewController {
    
    private weak var delegate: AddHuntDestinationDelegate?
    
    private var locationNum: String?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var locationNumLabel: UILabel!
    
    @IBOutlet weak var saveLocationButton: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var hintTextField: UITextField!
    
    static func create(creationVC: HuntCreationViewController) -> HuntLocationViewController {
        let huntLocationVC = HuntLocationViewController(nibName: String(describing: self.self), bundle: nil)
        huntLocationVC.delegate = creationVC
        huntLocationVC.locationNum = creationVC.getLocationNum()
        return huntLocationVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let press = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        mapView.addGestureRecognizer(press)
        displayLocationNum()
        styleSaveLocationButton()
    }
    
    func styleSaveLocationButton() {
        saveLocationButton.layer.borderWidth = 2
        saveLocationButton.layer.borderColor = UIColor.clear.cgColor
        saveLocationButton.layer.cornerRadius = 8
        saveLocationButton.layer.backgroundColor = UIColor.lightGray.cgColor
        saveLocationButton.isEnabled = false
    }
    
    func checkLocationReqs(sender: AnyObject) {
        if (titleTextField.text?.isEmpty)! || (hintTextField.text?.isEmpty)! {
            styleSaveLocationButton()
        } else {
            saveLocationButton.layer.backgroundColor = UIColor.blue.cgColor
            saveLocationButton.isEnabled = true;
        }
    }
    
    @IBAction func textFieldDidBeginEditing(_ textField: UITextField) {
        checkLocationReqs(sender: textField)
    }
    
    @IBAction func buttonTapped(_ sender:
        UIButton) {
        delegate?.add(destination: Destination(title: titleTextField.text!, location: Location(latitude: 8, longitude: 8, id: 8), hints: [Hint(description: "hint", id: 8)], id: 8))
        self.dismiss(animated: true, completion: nil)
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

    func displayLocationNum() {
        locationNumLabel.text = "Location #" + locationNum!
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
