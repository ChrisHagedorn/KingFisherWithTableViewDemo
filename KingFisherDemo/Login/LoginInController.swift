//
//  LoginInController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/30/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import Firebase


class LoginInController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        let gSignIn = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 230, height: 48))
        gSignIn.center = view.center
        view.addSubview(gSignIn)
        
        // Add sign out button
        let signOut = UIButton(frame: CGRect(x: 50, y: 50, width: 100, height: 30))
        signOut.backgroundColor = UIColor.red
        signOut.layer.cornerRadius = 5
        signOut.layer.borderWidth = 1
        signOut.layer.borderColor = UIColor.black.cgColor
        signOut.setTitle("Sign Out", for: .normal)
        signOut.center = view.center
        signOut.center.y = view.center.y + 100
        signOut.addTarget(self, action: #selector(self.signOut(_:)), for: .touchUpInside)
        self.view.addSubview(signOut)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func signOut(_ sender: UIButton) {
        print("Signing Out")
        GIDSignIn.sharedInstance().signOut()
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Failed to sign out")
            print(signOutError)
            return
        }
        
        print("Signed out")
        
    }
    
    
}
