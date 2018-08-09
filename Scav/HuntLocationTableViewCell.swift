//
//  HuntLocationTableViewCell.swift
//  Scav
//
//  Created by Mayki Hu on 8/8/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit

class HuntLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLocationTextLabel: UILabel!
    @IBOutlet weak var cellLocationNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
