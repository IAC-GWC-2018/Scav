//
//  HuntCreationViewController.swift
//  Scav
//
//  Created by Asma Sadia on 7/11/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//
import UIKit
class HuntCreationViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UIStackView!
    
    @IBOutlet weak var add: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    static func create() -> HuntCreationViewController {
        return HuntCreationViewController(nibName: String(describing: self.self), bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonTapped(_ sender:
        UIButton) {
        showHuntLocation()
    }


    @objc private func showHuntLocation() {
        let creationVC = HuntLocationViewController.create()
        present(creationVC, animated: true)
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
