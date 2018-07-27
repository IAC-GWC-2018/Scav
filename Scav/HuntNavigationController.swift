//
//  HuntNavigationController.swift
//  Scav
//
//  Created by Mayki Hu on 7/18/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit

class HuntNavigationController: UINavigationController {

    static func create() -> HuntNavigationController {
        let huntListViewController = HuntListViewController.create()
        return self.init(rootViewController: huntListViewController)
    }
    
}
