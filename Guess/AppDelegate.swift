//
//  AppDelegate.swift
//  Guess
//
//  Created by MingleChang on 2019/12/30.
//  Copyright © 2019 MingleChang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let lLaunchController = MCLaunchController()
        window!.rootViewController = lLaunchController
        window!.makeKeyAndVisible()
        return true
    }
}

