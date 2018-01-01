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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        setupWindow()

        return true
    }

    private func setupWindow() {
        let bounds = UIScreen.main.bounds
        window = UIWindow(frame: bounds)
        window?.backgroundColor = UIColor.white
        let feedService = PhotoFeedService()
        let feedPresenter = PhotoFeedPresenter(repository: feedService)
        let mainVC = PhotoFeedViewController(presenter: feedPresenter)
        let rootVC = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
    }
}
