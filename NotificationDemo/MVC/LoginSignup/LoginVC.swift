//
//  LoginVC.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 30/09/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var txt_password: UITextField!
    
    @IBOutlet weak var btn_login: UIButton!
    
    @IBOutlet weak var btn_signUp: UIButton!
    
    @IBOutlet weak var btn_forgotPassword: UIButton!
    
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
    
    @IBAction func btn_loginTapped(_ sender: UIButton) {
        callLoginAPI()
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_signUpTapped(_ sender: UIButton) {
        
    }
    
    
    @IBAction func btn_forgotPasswordTapped(_ sender: UIButton) {
        
    }
    
    

}

// MARK: - Utility methods
extension LoginVC {
    func setRootViewController()   {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nv = mainStoryboard.instantiateViewController(withIdentifier: "MenuRootNavigationController") as! UINavigationController
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = nv
        appdelegate.window?.makeKeyAndVisible()
    }
}


// MARK: - Web Services
extension LoginVC {
    func callLoginAPI() {
        var params = [String: Any]()
        let headers = ["Content-Type":"application/json"]
        params = ["username":txt_email.text!,"password":txt_password.text!]
        let urlStr = APIConfiguration.baseURL.rawValue + APIConfiguration.login.rawValue
        Alamofire.request(URL(string: urlStr)!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response)
            switch response.result {
            case .success:
                let dict = response.result.value as! NSDictionary
                if let userData = dict.value(forKey: "data") as? NSDictionary {
                    let token = userData.value(forKey: AppConfig.UserDefaultsKeys.token.rawValue) as! String
                    AppConfig.shared.token = token
                    //                print(user?.token!)
                    // set root view controller
                    self.setRootViewController()
                    self.callSendDeviceTokenAPI()
                }
                if let message = dict.value(forKey: "message") as? String {
                    DispatchQueue.main.async {
                        Utilities.showAlert(title: kAlertTitle, message: message, viewcontroller: self, okClick: { })
                    }
                }
            case .failure:
                print("failure")
            }
            
        }
    }
    
    func callSendDeviceTokenAPI() {
        var params = [String: String]()
        params = ["accessToken":AppConfig.shared.token,"deviceToken":AppConfig.shared.apnsToken]
        let urlStr = APIConfiguration.baseURL.rawValue + APIConfiguration.registerDevice.rawValue
        Alamofire.request(URL(string: urlStr)!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            print(response)
        }
    }
}
