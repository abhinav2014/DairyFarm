//
//  MainMenuModel.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 30/09/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import Foundation

struct MainMenuModel {
    var name: String?
    var image: String?
    init(dictionary: [String:Any]) {
        name = dictionary["name"] as? String
        image = dictionary["image"] as? String
    }
}
