//
//  AppDelegate.swift
//  Scav
//
//  Created by Dylan Shine on 7/11/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = HuntNavigationController.create()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}
