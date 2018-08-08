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
    private var hunt: Hunt?
    
    static func create(hunt: Hunt) -> CompletedHuntViewController {
        let vc = CompletedHuntViewController(nibName: String(describing: self.self), bundle: nil)
        vc.hunt = hunt
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func configure() {
        guard let hunt = hunt else {
            return
        }
        
        let message = "Congrats! You've completed \(hunt.title) hunt!"
        congratsLabel.text = message
    }
    
    @IBAction func completeButtonPress(_ sender: Any) {
        
    }
    
}
