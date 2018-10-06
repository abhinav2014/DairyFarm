//
//  AIDetailsVC.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 01/10/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import UIKit
import Alamofire
import DropDown
import BarcodeScanner

class AIDetailsVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var txt_AnimalID: UITextField!
    
    @IBOutlet weak var txt_AIDate: UITextField!
    
    @IBOutlet weak var btn_AIDate: UIButton!
    
    @IBOutlet weak var btn_submit: UIButton!
    
    //MARK: - Variables
    var animalsList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.callGetAnimalListAPI()
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
    
    // MARK : - Called Actions
    @IBAction func btn_backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btn_AIDateTapped(_ sender: UIButton) {
        txt_AIDate.becomeFirstResponder()
    }
    
    
    @IBAction func btn_submitTapped(_ sender: UIButton) {
        self.callAIDetailSaveAPI()
    }
    
    
    @IBAction func btn_scanTapped(_ sender: UIButton) {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        present(viewController, animated: true, completion: nil)
    }
    

}

// MARK: - Utility methods
extension AIDetailsVC {
    func parseAnimalData(response: NSArray) {
        self.animalsList = []
        for i in response {
            let animal = AnimalDetailsModel(dictionary: i as! NSDictionary)
            let animalId = animal?.id
            self.animalsList.append("\(animalId!)")
        }
    }
    
    func setUpDropDown(textField: UITextField) {
        let dropDown = DropDown()
        
        // The view to which the drop down will appear on
        dropDown.anchorView = textField // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = animalsList
        dropDown.cellNib = UINib(nibName: "DropDownView", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? DropDownView else { return }
            
            // Setup your custom UI components
            cell.optionLabel.text = dropDown.dataSource[index]
        }
        dropDown.textColor = .black
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txt_AnimalID.text = dropDown.dataSource[index]
        }
        
        dropDown.show()
    }
}


extension AIDetailsVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txt_AnimalID {
            self.setUpDropDown(textField: textField)
            return false
        } else if textField == txt_AIDate {
            let datePickerView = UIDatePicker()
            datePickerView.datePickerMode = .date
            textField.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(handleDatePickerForAIDate(sender:)), for: .valueChanged)
            return true
        } else {
            return true
        }
    }
    
    
    @objc func handleDatePickerForAIDate(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        txt_AIDate.text = dateFormatter.string(from: sender.date)
    }
    
}

//MARK: - Web Services
extension AIDetailsVC {
    func callAIDetailSaveAPI() {
        SVProgressHUD.show()
        let urlStr = APIConfiguration.baseURL.rawValue + APIConfiguration.AIDetailSave.rawValue
        let params = ["accessToken":AppConfig.shared.token,"id":txt_AnimalID.text!,"aiDate":txt_AIDate.text!]
        Alamofire.request(URL(string: urlStr)!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            print(response)
            if let responseData = response.result.value as? NSDictionary {
                if let success = responseData.value(forKey: "success") as? Int {
                    if success == 0 {
                        DispatchQueue.main.async {
                            Utilities.showAlert(title: kAlertTitle, message: responseData.value(forKey: "message") as! String, viewcontroller: self, okClick: {})
                        }
                    } else {
                        DispatchQueue.main.async {
                            Utilities.showAlert(title: kAlertTitle, message: "AI details saved successfully!", viewcontroller: self, okClick: {})
                        }
                    }
                }
            }
        }
    }
    
    func callGetAnimalListAPI() {
        SVProgressHUD.show()
        let params = ["accessToken":AppConfig.shared.token, "animalID":0] as [String : Any]
        let urlStr = APIConfiguration.baseURL.rawValue + APIConfiguration.getAnimals.rawValue
        Alamofire.request(URL(string: urlStr)!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            print(response)
            switch response.result {
            case .success:
                let dict = response.result.value as! NSDictionary
                if let message = dict["message"] as? String {
                    if message == "access_token expired" {
                        DispatchQueue.main.async {
                            Utilities.showAlert(title: kAlertTitle, message: "Session expired. Please login again", viewcontroller: self, okClick: {
                                Utilities.shared.setRootViewConroller(controller: RootVC.Login.rawValue)
                            })
                        }
                    }
                }
                if let arr = dict["data"] as? NSArray {
                    self.parseAnimalData(response: arr)
                }
                
            case .failure:
                print("Failure")
            }
        }
    }
}

// MARK: - Zbar delegate
extension AIDetailsVC: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        self.dismiss(animated: true, completion: nil)
        txt_AnimalID.text = code
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

