//
//  AnimalListVC.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 01/10/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import UIKit
import Alamofire

class AnimalListVC: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var table_animalList: UITableView!
    
    @IBOutlet weak var lbl_title: UILabel!
    
    // MARK: - Variables
    var animalsList = [AnimalDetailsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callGetAnimalListAPI()
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
    
    @IBAction func btn_backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Utility methods
extension AnimalListVC {
    func parseAnimalData(response: NSArray) {
        self.animalsList = []
        for i in response {
            let animal = AnimalDetailsModel(dictionary: i as! NSDictionary)
            self.animalsList.append(animal!)
        }
        DispatchQueue.main.async {
            self.table_animalList.reloadData()
        }
    }
}

// MARK : - UITableView methods

extension AnimalListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalListCell", for: indexPath) as! AnimalListCell
        let animal = self.animalsList[indexPath.row]
        cell.lbl1.text = "Animal ID: \(animal.id!)"
        cell.lbl2.text = "\(String(describing: animal.type!.typeName!)):\(String(describing: animal.liveStockGroup!.typeName!)):\(String(describing: animal.liveStockBreed!.breedName!))"
        cell.lbl3.text = "Medical Number: \(animal.medicalNumber!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

// MARK: - Web Services
extension AnimalListVC {
    func callGetAnimalListAPI() {
        let params = ["accessToken":AppConfig.shared.token, "animalID":0] as [String : Any]
        let urlStr = APIConfiguration.baseURL.rawValue + APIConfiguration.getAnimals.rawValue
        Alamofire.request(URL(string: urlStr)!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            print(response)
            switch response.result {
            case .success:
                let dict = response.result.value as! NSDictionary
                let arr = dict["data"] as! NSArray
                self.parseAnimalData(response: arr)
            case .failure:
                print("Failure")
            }
        }
    }
}
