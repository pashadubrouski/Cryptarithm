//
//  AppDelegate.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 18.11.24.
//

import UIKit
import SwiftUI
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let rootContainer: RootContainer = RootContainer()
    var applicationCoordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startCoordinator()
        setupServices()
        return true
    }

    private func startCoordinator() {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        let window = makeWindow()
        window.rootViewController = navigationController
        applicationCoordinator = ApplicationCoordinator(window: window,
                                                        router: navigationController,
                                                        container: rootContainer)
        applicationCoordinator?.start()
    }

    private func makeWindow() -> UIWindow {
        let window = UIWindow()
        window.makeKeyAndVisible()
        return window
    }

    private func setupServices() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
}

