//
//  AppDelegate.swift
//  bootstrap
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import core
import domain
import data
import feature
import Swinject
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PlankAppDelegate {

    public let assembler: Assembler = {
        var modules: [Assembly] = []
        
        modules.append(contentsOf: dataModules)
        modules.append(contentsOf: featureModules)
        
        return Assembler(modules)
    }()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if #available(iOS 13.0, *) {
            // In iOS 13 setup is done in SceneDelegate
        }
        else {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = SearchViewController.create()
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
            UIApplication.shared.statusBarStyle = .darkContent
        } else {
            UIApplication.shared.statusBarStyle = .default
        }
        
        if #available(iOS 13.0, *) {
            // In iOS 13 setup is done in SceneDelegate
        } else {
            window!.makeKeyAndVisible()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

