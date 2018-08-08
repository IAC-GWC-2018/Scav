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
    
    private var locationNum: Int?
    
    private var hints = [Hint]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var annotation = MKPointAnnotation()
    
    @IBOutlet weak var locationTitleTextField: UITextField!
    
    @IBOutlet weak var hintTextField: UITextField!
    
    @IBOutlet weak var addHintButton: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBAction func hintButtonTapped(_ sender:
        UIButton) {
        addHint()
    }
    
    @IBOutlet weak var hintTableView: UITableView!
    
    private func addHint() {
        if let hintText = hintTextField.text {
            hints.append(Hint(description: hintText, id: hints.count + 1))
            let hintLabel = UILabel()
            hintLabel.text = hintText
            hintTableView.insertRows(at: [IndexPath(row: hints.count - 1, section: 0)], with: .automatic)
        }
        hintTextField.text = ""
    }
    
    @IBOutlet weak var locationNumLabel: UILabel!
    
    @IBOutlet weak var saveLocationButton: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    static func create(creationVC: HuntCreationViewController) -> HuntLocationViewController {
        let huntLocationVC = HuntLocationViewController(nibName: String(describing: self.self), bundle: nil)
        huntLocationVC.delegate = creationVC
        huntLocationVC.locationNum = creationVC.getLocationNum()
        return huntLocationVC
    }
    
    private var selectedLocation: Location?
    
    private var locationTitle: String? {
        return locationTitleTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let press = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        mapView.addGestureRecognizer(press)
        displayLocationNum()
        styleSaveLocationButton()
        configureTableView()
    }
    
    func styleSaveLocationButton() {
        saveLocationButton.layer.borderWidth = 2
        saveLocationButton.layer.borderColor = UIColor.clear.cgColor
        saveLocationButton.layer.cornerRadius = 8
        saveLocationButton.layer.backgroundColor = UIColor.lightGray.cgColor
        saveLocationButton.isEnabled = false
    }
    
    func checkLocationReqs(sender: AnyObject) {
        if (titleTextField.text?.isEmpty)! || (hints.count < 1) || (mapView.annotations.count < 1) {
            styleSaveLocationButton()
            print(hints.count)
            print(mapView.annotations.count)
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
        delegate?.add(destination: Destination(title: titleTextField.text!, location: Location(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude, id: locationNum!), hints: hints, id: locationNum!))
        self.dismiss(animated: true, completion: nil)
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
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func back (_ sender:
        UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayLocationNum() {
        locationNumLabel.text = "Location #" + String(locationNum!)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    private func configureTableView() {
        hintTableView.dataSource = (self as UITableViewDataSource)
        hintTableView.delegate = self as? UITableViewDelegate
        hintTableView.rowHeight = UITableViewAutomaticDimension
        hintTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        hintTableView.register(UINib(nibName: String(describing: HuntCreationLocationTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HuntCreationLocationTableViewCell.self))
    }


}

extension HuntLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hints.count
    }
    
    private func insertLocationData(_ cell: HuntCreationLocationTableViewCell, cellForRowAt indexPath: IndexPath) {
        let hint = hints[indexPath.row]
        cell.cellLocationTextLabel.text = (String) (indexPath.row + 1)
        cell.cellLocationNameLabel.text = hint.description
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HuntCreationLocationTableViewCell.self)) as? HuntCreationLocationTableViewCell else {
            return UITableViewCell()
        }
        
        insertLocationData(cell, cellForRowAt: indexPath)
        
        return cell
    }
}


