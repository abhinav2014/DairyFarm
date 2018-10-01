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
    
    // MARK: - Alert Methods
    static func showAlert(title:String, message: String, viewcontroller: UIViewController, leftButtonClick: @escaping () -> Void, rightButtonClick: @escaping () -> Void) {
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
}



