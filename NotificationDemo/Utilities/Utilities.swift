//
//  Utilities.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 30/09/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import Foundation
import UIKit


struct Utilities {
    static var shared = Utilities()
    private init(){}
    // MARK: - Alert Methods
    static func showAlert(title:String, message: String, viewcontroller: UIViewController, okClick: @escaping () -> Void) {
        print("Alert called.")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            okClick()
        }))
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWithTwoActions(title:String, message: String, viewcontroller: UIViewController, leftButtonClick: @escaping () -> Void, rightButtonClick: @escaping () -> Void) {
        print("Alert called.")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) in
            leftButtonClick()
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            rightButtonClick()
        }))
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Email Validator
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluate(with: testStr)
        
        return result
    }
    
    //MARK: - Set Root View Controller
    
    
    func setRootViewConroller(controller: String) {
        if controller == RootVC.Login.rawValue {
            let loginStoryboard = UIStoryboard(name: "LoginSignup", bundle: nil)
            let nv = loginStoryboard.instantiateViewController(withIdentifier: StoryboardID.loginNavigationController.rawValue) as! UINavigationController
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window?.rootViewController = nv
            appdelegate.window?.makeKeyAndVisible()
        } else {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nv = mainStoryboard.instantiateViewController(withIdentifier: "MenuRootNavigationController") as! UINavigationController
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window?.rootViewController = nv
            appdelegate.window?.makeKeyAndVisible()
        }
        
        
    }
    // MARK: - SVProgessHUD appearance
    func setSVP() {
//        SVProgressHUD.appearance().backgroundColor = UIColor.black
    }

    
}



