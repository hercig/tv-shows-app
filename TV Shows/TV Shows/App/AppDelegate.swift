//
//  AppDelegate.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.07.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var appController: AppController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.overrideUserInterfaceStyle = .light
        self.window = window
        
        appController = AppController(window: window)
        appController?.startApp()
        
        return true
    }
}
