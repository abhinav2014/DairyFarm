//
//  MenuVC.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 30/09/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collection_mainMenu: UICollectionView!
    
    // MARK: - Variables
    var menuItems = [MainMenuModel]()
    
    var myClosure:((_ sender:UIButton)->())? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myClosure = { (sender:UIButton) -> Void in
            Utilities.showAlert(title: "NotificationDemo", message: "Notification Received.", viewcontroller: self, leftButtonClick: {
                print("Closure leftButtonClick called.")
            }, rightButtonClick: {
                print("Closure rightButtonClick called.")
            })
        }
        
        setMenuData()
        // myClosure!(sender)  // Closure called on button action or whatever else
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

// MARK: - Initial Set Up
extension MenuVC {
    func setMenuData() {
        let item1 = MainMenuModel(dictionary: ["name":"Register", "image":"register"])
        let item2 = MainMenuModel(dictionary: ["name":"Artificial Insemination", "image":"insemination"])
        let item3 = MainMenuModel(dictionary: ["name":"Milk Feed", "image":"milk"])
        let item4 = MainMenuModel(dictionary: ["name":"Medicate", "image":"medicate"])
        let item5 = MainMenuModel(dictionary: ["name":"Settings", "image":"settings"])
        let item6 = MainMenuModel(dictionary: ["name":"Info", "image":"info"])
        menuItems = [item1,item2,item3,item4,item5,item6]
        collection_mainMenu.reloadData()
    }
}

// MARK: - CollectionView methods
extension MenuVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainMenuCell", for: indexPath) as! MainMenuCell
        let menuItem = menuItems[indexPath.row]
        cell.lbl_title.text = menuItem.name
        cell.img_item.image = UIImage(named: menuItem.image!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if indexPath.row == 0 {
            let vc = storyboard.instantiateViewController(withIdentifier: "AnimalListVC") as! AnimalListVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = storyboard.instantiateViewController(withIdentifier: "AIDetailsVC") as! AIDetailsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 30) / 2
        return CGSize(width: width, height: width)
    }
    
}


