//
//  AppDelegate.swift
//  FoursquareClone
//
//  Created by Rafi Saar on 09/08/2021.
//  Copyright © 2021 Syncopa Productions. All rights reserved.
//

import UIKit
import ParseSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        ParseSwift.initialize(applicationId: "9LIUWXEJM6yscQrgPKxsltlTF5hHfu22cv8XjfRA", clientKey: "n17SWSSq7wCZrAgfJgVEh1K4qFoFEJCZUeDn437M", serverURL: URL(string: "https://parseapi.back4app.com/")!)

        
        
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

