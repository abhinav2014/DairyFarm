//
//  AnimalRegistrationVC.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 01/10/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import BarcodeScanner

class AnimalRegistrationVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var txt_animalID: UITextField!
    
    @IBOutlet weak var txt_medicalNo: UITextField!
    
    @IBOutlet weak var txt_type: UITextField!
    
    @IBOutlet weak var txt_group: UITextField!
    
    @IBOutlet weak var txt_breed: UITextField!
    
    @IBOutlet weak var txt_dob: UITextField!
    
    @IBOutlet weak var txt_gender: UITextField!
    
    @IBOutlet weak var txt_currentWt: UITextField!
    
    @IBOutlet weak var txt_birthWt: UITextField!
    
    @IBOutlet weak var btn_scanBarCode: UIButton!
    
    @IBOutlet weak var btn_calendar: UIButton!
    
    
    @IBOutlet weak var btn_lastHeatDate: UIButton!
    
    
    @IBOutlet weak var btn_animalPic: UIButton!
    
    @IBOutlet weak var btn_register: UIButton!
    
    @IBOutlet weak var txt_lastHeatDate: UITextField!
    // MARK: - Variables
    var selectedTypeId = 1000
    var selectedGroupId = 1000
    var selectedBreedId = 1000
    var dropDownDict = [[String:Any]]()
//    var dropDown = DropDown()
    
    // MARK: - View Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
//        Utilities.shared.setSVP()
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
    
    // MARK: - Called Actiona
    
    @IBAction func btn_backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_scanTapped(_ sender: UIButton) {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func btn_calendarTapped(_ sender: UIButton) {
        switch sender {
        case btn_calendar:
            txt_dob.becomeFirstResponder()
        case btn_lastHeatDate:
            txt_lastHeatDate.becomeFirstResponder()
        default:
            print("Invalid option.")
        }
    }
    
    @IBAction func btn_animalPicTapped(_ sender: UIButton) {
    }
    
    @IBAction func btn_submitTapped(_ sender: UIButton) {
        if txt_dob.text == "" {
            Utilities.showAlert(title: kAlertTitle, message: AlertMessages.enterDOB.rawValue, viewcontroller: self, okClick: {})
        } else if txt_currentWt.text == "" {
            Utilities.showAlert(title: kAlertTitle, message: AlertMessages.enterCurrentWeight.rawValue, viewcontroller: self, okClick: {})
        } else {
            callAnimalRegistrationAPI()
        }
    }
    
    
}

// MARK: - Initial Setup
extension AnimalRegistrationVC {
    func configureView() {
        configureTextField(textField: txt_type)
        configureTextField(textField: txt_group)
        configureTextField(textField: txt_breed)
        configureTextField(textField: txt_gender)
        
        btn_animalPic.layer.borderWidth = 1
        btn_animalPic.layer.borderColor = UIColor.black.cgColor
        btn_animalPic.layer.cornerRadius = 5
    }
    
    func configureTextField(textField: UITextField) {
        let imgSearch = UIImageView()
        imgSearch.contentMode = .scaleAspectFit
        let img = UIImage(named: "drop-down");
        imgSearch.image = img;
        imgSearch.frame = CGRect(x: textField.frame.size.width - 45 , y: 5, width: 12, height: 12)
        textField.rightView = imgSearch
        textField.rightViewMode = .always
    }
    
    func setUpDropDown(textField: UITextField) {
        let dropDown = DropDown()
        
        // The view to which the drop down will appear on
        dropDown.anchorView = textField // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        var dropDownDataSource = [String]()
        var dropDownDict = [[String:Any]]()
        if textField == txt_type {
            for i in typeData {
                let type = i.typeName
                dropDownDataSource.append(type!)
                dropDownDict.append(["id":i.typeId!,"name":i.typeName!])
            }
        } else if textField == txt_group {
            let txtType = txt_type.text
            for i in typeData {
                if i.typeName == txtType {
                    let groups = i.groups
                    for k in groups! {
                        let group = k.typeName
                        dropDownDataSource.append(group!)
                        dropDownDict.append(["id":k.groupID!,"name":i.typeName!])
                    }
                }
            }
        } else if textField == txt_breed {
            let txtType = txt_type.text
            let txtGroup = txt_group.text
            for i in typeData {
                if i.typeName == txtType {
                    for k in i.groups! {
                        if k.typeName == txtGroup {
                            for j in k.breed! {
                                let breed = j.breedName
                                dropDownDataSource.append(breed!)
                                dropDownDict.append(["id":j.breedID!,"name":j.breedName!])
                            }
                        }
                    }
                }
            }
        } else if textField == txt_gender {
            dropDownDataSource = ["Male","Female"]
        }
        self.dropDownDict = dropDownDict
        dropDown.dataSource = dropDownDataSource
        dropDown.cellNib = UINib(nibName: "DropDownView", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? DropDownView else { return }
            
            // Setup your custom UI components
            cell.optionLabel.text = dropDown.dataSource[index]
        }
        dropDown.textColor = .black
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            switch textField {
            case self.txt_type:
                self.txt_type.text = dropDown.dataSource[index]
                self.selectedTypeId = dropDownDict[index]["id"] as! Int
            case self.txt_group:
                self.txt_group.text = dropDown.dataSource[index]
                self.selectedGroupId = dropDownDict[index]["id"] as! Int
            case self.txt_breed:
                self.txt_breed.text = dropDown.dataSource[index]
                self.selectedBreedId = dropDownDict[index]["id"] as! Int
            case self.txt_gender:
                self.txt_gender.text = dropDown.dataSource[index]
            default:
                print("Invalid...")
            }
        }
        dropDown.show()
    }
}

// MARK: - TxtField Delegates
extension AnimalRegistrationVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txt_type || textField == txt_group || textField == txt_breed || textField == txt_gender {
            self.view.endEditing(true)
            self.setUpDropDown(textField: textField)
            return false
        } else if textField == txt_dob {
            let datePickerView = UIDatePicker()
            datePickerView.datePickerMode = .date
            textField.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(handleDatePickerForDOB(sender:)), for: .valueChanged)
            return true
        } else if textField == txt_lastHeatDate {
            let datePickerView = UIDatePicker()
            datePickerView.datePickerMode = .date
            textField.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(handleDatePickerForLastHeatDate(sender:)), for: .valueChanged)
            return true
        } else {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            if textField == txt_dob {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                txt_dob.text = dateFormatter.string(from: Date())
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                txt_lastHeatDate.text = dateFormatter.string(from: Date())
            }
        }
    }
    
    
    @objc func handleDatePickerForDOB(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        txt_dob.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func handleDatePickerForLastHeatDate(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        txt_lastHeatDate.text = dateFormatter.string(from: sender.date)
    }
}

//MARK: - Web Services
extension AnimalRegistrationVC {
    func callAnimalRegistrationAPI() {
        SVProgressHUD.show()
        let params = [
            "data": [
                "currentWeight": txt_currentWt.text!,
                "imageName": "string",
                "medicalNumber": 0,
                "liveStockGroup": [
                    "groupID": selectedGroupId,
                    "typeID": selectedTypeId
                ],
                "dateOfBirth": txt_dob.text!,
                
                "type": [
                    "typeId": selectedTypeId
                ],
                "createdDate": 0,
                "lastHeatDate": txt_lastHeatDate.text!,
                "birthWeight": 50,
                "liveStockBreed": [
                    "breedID": selectedBreedId,
                    "groupId": selectedGroupId
                ],
                "animalCode": 0
            ],
            "accessToken": AppConfig.shared.token
            ] as [String : Any]
        print(params)
        let urlStr = APIConfiguration.baseURL.rawValue + APIConfiguration.animalRegistration.rawValue
        Alamofire.request(URL(string: urlStr)!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            print(response)
            switch response.result {
            case .success:
                print("success")
                let dict = response.result.value as! NSDictionary
                let success = dict["success"] as! Int
                
                if success == 1 {
                    DispatchQueue.main.async {
                        Utilities.showAlert(title: kAlertTitle, message: "Animal registered successfully", viewcontroller: self, okClick: {})
                    }
                } else {
                    let message = dict["message"] as! String
                    DispatchQueue.main.async {
                        Utilities.showAlert(title: kAlertTitle, message: message, viewcontroller: self, okClick: {})
                    }
                }
            case .failure:
                print("failure")
            }
        }
    }
    
}

// MARK: - Zbar delegate
extension AnimalRegistrationVC: BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        self.dismiss(animated: true, completion: nil)
        txt_animalID.text = code
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Enums
extension AnimalRegistrationVC {
    enum AlertMessages: String {
        case savedSuccessfully = "Animal registered successfully!"
        case enterCurrentWeight = "Please enter current weight!"
        case enterDOB = "Please enter Date of Birth!"
    }
}



/*
 [
 "data": [
 "currentWeight": 0,
 "imageName": "string",
 "medicalNumber": "string",
 "liveStockGroup": [
 "groupID": 0,
 "typeID": 0
 ],
 "dateOfBirth": "string",
 "ownerId": 0,
 "type": [
 "typeId": 0
 ],
 "createdDate": 0,
 "lastHeatDate": 0,
 "birthWeight": 0,
 "liveStockBreed": [
 "breedID": 0,
 "groupId": 0
 ],
 "animalCode": 0
 ],
 "accessToken": "string"
 ]
 
 */
