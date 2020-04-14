//
//  Login.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/30/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import Firebase

@UIApplicationMain
class Login: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    
    var window: UIWindow?
    
    
    func changeData() {
        Database.database().reference().child("products").observeSingleEvent(of: .value) { (snapshot) in
            guard let rawData = snapshot.value as? [[String: Any]] else { return }
            Database.database().reference().child("products").removeValue()
            
            for item in rawData {
                let productId = "product_\(item["id"] as! Int)"
                Database.database().reference().child("products")
                    .child(String(productId)).setValue(item)
            }
        }
        
        Database.database().reference().child("featuredProducts").observeSingleEvent(of: .value) { (snapshot) in
            guard let rawData = snapshot.value as? [[String: Any]] else { return }
            Database.database().reference().child("featuredProducts").removeValue()
            
            for item in rawData {
                let productId = "product_\(item["id"] as! Int)"
                Database.database().reference().child("featuredProducts")
                    .child(String(productId)).setValue(item)
            }
        }
        
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        changeData()
        // Override point for customization after application launch.
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        
//        if Auth.auth().currentUser != nil { //Log the user in if they had previously logged in.
//            // show home screen
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
//            window?.rootViewController = vc
//        }

        return true
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("Running sign in")
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            print(fullName!)
            print(email!)
           // var currentCustomer = Customer(userId: userId!, idToken: idToken!, fullName: fullName!, givenName: givenName!, familyName: familyName!, email: email!)
            
        }
        
        // Firebase sign in
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Firebase sign in error")
                print(error)
                return
            }
            print("User is signed in with Firebase")
            self.window?.rootViewController!.performSegue(withIdentifier: "moveToTabBar", sender: nil)
        }
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        print("User has disconnected")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
