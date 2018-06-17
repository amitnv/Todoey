//
//  AppDelegate.swift
//  Todoey
//
//  Created by Amit Vaidya on 02/06/18.
//  Copyright © 2018 Tech Navigator. All rights reserved.
//

import UIKit

import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        
        do {
            _ = try Realm()
        } catch {
            print("Error initialising realm, \(error)")
        }
        
        return true
    }

}

