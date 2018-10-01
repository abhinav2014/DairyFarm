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
        callSignUpAPI()
    }
    
    @IBAction func btn_loginTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}

// MARK: - Web Services
extension SignUpVC {
    func callSignUpAPI() {
        var params = [String: String]()
        let headers = ["Content-type":"Application/json","Accept":"Application/json"]
        params = ["name":"txt_firstName.text!","lastName":"txt_lastName.text!","username":"txt_userName.text!","email":"txt_email.text!" ,"password":"txt_password.text!"]
        let urlStr = APIConfiguration.baseURL.rawValue + APIConfiguration.signUp.rawValue
        Alamofire.request(URL(string: urlStr)!, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            print(response)
        }
        
    }
}
