//
//  HuntCreationViewController.swift
//  Scav
//
//  Created by Asma Sadia on 7/11/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//
import UIKit

class HuntCreationViewController: UIViewController, AddHuntDestinationDelegate {
    func add(destination: Destination) {
        destinations.append(destination)
        displayLocationNum()
        locationTableView.insertRows(at: [IndexPath(row: destinations.count - 1, section: 0)], with: .automatic)
    }
    
    func checkHuntReq() {
        if(huntTitleField.text?.isEmpty == true) || (huntDescriptionField.text?.isEmpty == true) ||  (destinations.count < 1) {
            saveHuntButton.isEnabled = false
            saveHuntButton.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            saveHuntButton.layer.backgroundColor = UIColor.blue.cgColor
            saveHuntButton.isEnabled = true
        }
    }
    
    @IBAction func textFieldDidBeginEditing() {
        checkHuntReq()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkHuntReq()
    }
    
    @IBOutlet weak var huntTitleField: UITextField!
    
    private var destinations = [Destination]()
            
    @IBOutlet weak var saveHuntButton: UIButton!
    
    @IBOutlet weak var add: UIButton!

    @IBOutlet weak var locationNumLabel: UILabel!
    
    @IBOutlet weak var locationTableView: UITableView!
    
    @IBOutlet weak var huntDescriptionField: UITextField!
    
    @IBOutlet weak var backButton: UIButton!
    
    static func create() -> HuntCreationViewController {
        return HuntCreationViewController(nibName: String(describing: self.self), bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayLocationNum()
        configureTableView()
        styleSaveHuntButton()
    }
    
    private func configureTableView() {
        locationTableView.dataSource = (self as UITableViewDataSource)
        locationTableView.delegate = self as? UITableViewDelegate
        locationTableView.rowHeight = UITableViewAutomaticDimension
        locationTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        locationTableView.register(UINib(nibName: String(describing: HuntLocationTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HuntLocationTableViewCell.self))
    }
    
    func styleSaveHuntButton() {
        saveHuntButton.layer.borderWidth = 2
        saveHuntButton.layer.borderColor = UIColor.clear.cgColor
        saveHuntButton.layer.cornerRadius = 8
        saveHuntButton.layer.backgroundColor = UIColor.lightGray.cgColor
        saveHuntButton.isEnabled = false
    }
    
    @IBAction func saveHunt(_ sender: UIButton) {
        let hunt = Hunt(title: huntTitleField.text!, description: huntDescriptionField.text!, destinations: destinations, id: 0)
        
        HuntNetworkManager.shared.process(.createHunt(hunt: hunt)) { (data, response, error) in
            if let error = error {
                print(error)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        showHuntLocation()
    }

    func displayLocationNum() {
        locationNumLabel.text = "Add Location #" + String(getLocationNum())
    }
    
    @objc private func showHuntLocation() {
        let locationVC = HuntLocationViewController.create(creationVC: self)
        present(locationVC, animated: true)
    }

    @IBAction func back (_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func getLocationNum() -> Int {
        return destinations.count + 1
    }
}

extension HuntCreationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    private func insertLocationData(_ cell: HuntLocationTableViewCell, cellForRowAt indexPath: IndexPath) {
        let location = destinations[indexPath.row]
        cell.cellLocationTextLabel.text = (String) (indexPath.row + 1)
        cell.cellLocationNameLabel.text = location.title
        print(location.location.longitude)
        print(location.location.latitude)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HuntLocationTableViewCell.self)) as? HuntLocationTableViewCell else {
            return UITableViewCell()
        }
        
        insertLocationData(cell, cellForRowAt: indexPath)
        
        return cell
    }
}
