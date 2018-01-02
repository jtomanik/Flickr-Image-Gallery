//
//  AppDelegate.swift
//  Flickr Image Gallery
//
//  Created by Jakub Tomanik on 27/12/2017.
//  Copyright © 2017 Jakub Tomanik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var rootConnector: RootConnector!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        rootConnector = RootConnector()
        setupWindow()

        return true
    }

    private func setupWindow() {
        let bounds = UIScreen.main.bounds
        window = UIWindow(frame: bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = rootConnector.start()
        self.window?.makeKeyAndVisible()
    }
}
