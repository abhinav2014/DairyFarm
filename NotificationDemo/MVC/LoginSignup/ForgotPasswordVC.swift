//
//  ForgotPasswordVC.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 30/09/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var btn_submit: UIButton!
    
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
    
    @IBAction func btn_submitTapped(_ sender: UIButton) {
    }
    
    @IBAction func btn_loginTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
