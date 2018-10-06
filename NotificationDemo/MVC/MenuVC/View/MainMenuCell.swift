//
//  MainMenuCell.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 30/09/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import UIKit

class MainMenuCell: UICollectionViewCell {
    
    
    @IBOutlet weak var img_item: UIImageView!
    
    @IBOutlet weak var lbl_title: UILabel!
    
    @IBOutlet weak var img_comingSoon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
    }
    
}
