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
    
    private var destinations = [Destination]()
        
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UIStackView!
    
    @IBOutlet weak var add: UIButton!

    @IBOutlet weak var locationNumLabel: UILabel!
    
    @IBOutlet weak var locationTableView: UITableView!
    
    @IBOutlet weak var backButton: UIButton!
    
    static func create() -> HuntCreationViewController {
        return HuntCreationViewController(nibName: String(describing: self.self), bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayLocationNum()
        configureTableView()
    }
    
    private func configureTableView() {
        locationTableView.dataSource = (self as UITableViewDataSource)
        locationTableView.delegate = self as? UITableViewDelegate
        locationTableView.rowHeight = UITableViewAutomaticDimension
        locationTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        locationTableView.register(UINib(nibName: String(describing: HuntCreationLocationTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HuntCreationLocationTableViewCell.self))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonTapped(_ sender:
        UIButton) {
        showHuntLocation()
    }

    func displayLocationNum() {
        locationNumLabel.text = "Add Location #" + String(getLocationNum())
    }
    
    @objc private func showHuntLocation() {
        let locationVC = HuntLocationViewController.create(creationVC: self)
        present(locationVC, animated: true)
    }

    @IBAction func back (_ sender:
    UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func getLocationNum() -> Int {
        return destinations.count + 1
    }
    
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destinationViewController.
//     // Pass the selected object to the new view controller.
//        if let locationVC = segue.destination as? HuntLocationViewController {
//            locationVC.delegate = self
//        }
//     }
}

extension HuntCreationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    private func insertLocationData(_ cell: HuntCreationLocationTableViewCell, cellForRowAt indexPath: IndexPath) {
        let location = destinations[indexPath.row]
        cell.cellLocationTextLabel.text = (String) (indexPath.row + 1)
        cell.cellLocationNameLabel.text = location.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HuntCreationLocationTableViewCell.self)) as? HuntCreationLocationTableViewCell else {
            return UITableViewCell()
        }
        
        insertLocationData(cell, cellForRowAt: indexPath)
        
        return cell
    }
}
