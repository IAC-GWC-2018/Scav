//
//  CompletedHuntViewController.swift
//  Scav
//
//  Created by Chloe Gottleib on 8/8/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit
import Gifu

class CompletedHuntViewController: UIViewController {

    @IBOutlet weak var congratsLabel: UILabel!
    @IBOutlet weak var destinationTableVIew: UITableView!
    @IBOutlet weak var gifImageView: GIFImageView!
    @IBOutlet weak var completeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func completeButtonPress(_ sender: Any) {
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
