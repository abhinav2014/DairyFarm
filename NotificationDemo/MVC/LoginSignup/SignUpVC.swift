//
//  SignUpVC.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 30/09/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import UIKit
import Alamofire

class SignUpVC: UIViewController {
    
    @IBOutlet weak var txt_firstName: UITextField!
    
    @IBOutlet weak var txt_lastName: UITextField!
    
    @IBOutlet weak var txt_userName: UITextField!
    
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var txt_password: UITextField!
    
    @IBOutlet weak var btn_signUp: UIButton!
    
    @IBOutlet weak var btn_login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Called Actions
    @IBAction func btn_signUpTapped(_ sender: UIButton) {
        
        self.view.endEditing(true)
        callSignUpAPI()
    }
    
    @IBAction func btn_loginTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Utility methods
extension SignUpVC {
    
}


// MARK: - Web Services
extension SignUpVC {
    func callSignUpAPI() {
        SVProgressHUD.show()
        var params = [String: Any]()
        let headers = ["Content-Type":"application/json"]
        params = ["name":txt_firstName.text!,"lastName":txt_lastName.text!,"username":txt_userName.text!,"email":txt_email.text! ,"password":txt_password.text!]
        let urlStr = APIConfiguration.baseURL.rawValue + APIConfiguration.signUp.rawValue
        Alamofire.request(URL(string: urlStr)!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            print(response)
            let dict = response.result.value as! NSDictionary
            if let userData = dict.value(forKey: "data") as? NSDictionary {
                let user = User(dictionary: userData.value(forKey: "user") as! NSDictionary)
//                print(user?.token!)
                let token = user?.token!
                AppConfig.shared.token = token!
                // set root view controller
                Utilities.shared.setRootViewConroller(controller: RootVC.Menu.rawValue)
            }
            if let message = dict.value(forKey: "message") as? String {
                DispatchQueue.main.async {
                    Utilities.showAlert(title: kAlertTitle, message: message, viewcontroller: self, okClick: { })
                }
            }
        }
    }
}
