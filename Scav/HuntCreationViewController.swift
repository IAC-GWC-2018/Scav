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
    
    @IBOutlet weak var stackView: UIStackView!
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
    
    @IBAction func buttonTapped(_ sender: Any) {
        let button = UIButton()
        button.setTitle("Test", for: .normal)
        button.backgroundColor = UIColor.black
        
        stackView.addArrangedSubview(button)
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
