//
//  OrderInfoController.swift
//  KingFisherDemo
//
//  Created by Chris Hagedorn on 8/28/19.
//  Copyright © 2019 Chris Hagedorn. All rights reserved.
//

import UIKit

class OrderInfoController: UIViewController {
    @IBOutlet weak var footerView: ShoppingCartFooter!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var adressInput: UITextField!
    @IBOutlet weak var telephoneInput: UITextField!
    
    @IBAction func confirmOrder(_ sender: Any) {
//        let name = nameInput.text!
//        let adress = adressInput.text!
//        let telephone = telephoneInput.text!
//
//        //Send email to user confirming order
//        if MFMailComposeViewController.canSendMail() {
//            let mail = MFMailComposeViewController() //Create the VC to send
//            mail.mailComposeDelegate = self
//            mail.setToRecipients(["hagedornc@ismanila.org"])
//            mail.setSubject("Order Form")
//            mail.setMessageBody("<p><b>Client name </b>\(name), \(adress), \(telephone)</p>", isHTML: true)
//            present(mail, animated: true) //Presenting the VC need to autosend
//        } else {
//            print("Application is not able to send an email")
//        }
//
//        //MARK: MFMail Compose ViewController Delegate method
//        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//            controller.dismiss(animated: true)}
//
    }
    
    
    static func create() ->  OrderInfoController {
        return UIStoryboard(name: "OrderInfoController", bundle: nil).instantiateViewController(withIdentifier: "OrderInfoController") as! OrderInfoController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        footerView.buttonHide()
        //TODO: Hide Tab bar
        self.tabBarController!.tabBar.isHidden = true
    }
    
}
