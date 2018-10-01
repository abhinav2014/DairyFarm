//
//  AnimalListCell.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 01/10/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import UIKit

class AnimalListCell: UITableViewCell {
    
    @IBOutlet weak var img_animal: UIImageView!
    
    @IBOutlet weak var btn_options: UIButton!
    
    @IBOutlet weak var lbl1: UILabel!
    
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var lbl3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
