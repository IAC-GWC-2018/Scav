//
//  UserLocationAlertViewController.swift
//  Scav
//
//  Created by Chloe Gottleib on 7/11/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit

class UserLocationAlertViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationUsageExplanation: UILabel!
    @IBOutlet weak var letsPlay: UIButton!
    @IBOutlet weak var iDontLikeFun: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    static func create() -> UserLocationAlertViewController {
        return UserLocationAlertViewController(nibName: String(describing: self.self), bundle: nil)
    }
    
    @IBAction func acceptButton(_ sender: UIButton) {
        
     }
    
    @IBAction func cancelButton(_ sender: UIButton) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
