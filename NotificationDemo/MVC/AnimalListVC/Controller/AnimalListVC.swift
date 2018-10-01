//
//  AnimalListVC.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 01/10/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import UIKit

class AnimalListVC: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var table_animalList: UITableView!
    
    @IBOutlet weak var lbl_title: UILabel!
    
    // MARK: - Variables
    var animalsList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        animalsList = ["Animal1","Animal2","Animal3","Animal4","Animal5"]
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

// MARK : - UITableView methods

extension AnimalListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalListCell", for: indexPath) as! AnimalListCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
