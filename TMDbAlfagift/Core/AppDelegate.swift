//
//  AppDelegate.swift
//  TMDbAlfagift
//
//  Created by Michael Lie on 16/09/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let rootVC = UINavigationController(rootViewController: MainViewController())
        rootVC.navigationBar.isHidden = true
        window?.rootViewController = rootVC
        
        return true
    }


}

