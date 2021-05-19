/*
**********************************************************
*   Statement of Compliance with the Stated Honor Code   *
**********************************************************
I hereby declare on my honor that:
 
 (1) All work is completely my own in this examination app.
 (2) I did NOT talk to anyone about the exam including my classmates.
 (3) I did NOT receive any help about how to develop the exam app.
 (4) I did NOT give any help to anyone about how to develop the exam app.
 (5) I did NOT ask questions to GTA or UTA about the exam app.
 
I am hereby writing my name as my signature to declare that the above statements are true:
   
      Ahmad Rasool Malik
 
**********************************************************
 */


//  AppDelegate.swift
//  MovieStars
//
//  Created by Ahmad on 5/4/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
 
        readActorDataFile()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        /*
        **************************************************
        Write country data file just before app terminates
        **************************************************
        */
        writeActorDataFile()
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


