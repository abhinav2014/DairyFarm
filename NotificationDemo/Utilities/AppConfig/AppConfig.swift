//
//  AppConfig.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 02/10/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import Foundation

struct AppConfig {
    static var shared = AppConfig()
    private init(){}
    var userName: String {
        get {
            return UserDefaults.standard.value(forKey: UserDefaultsKeys.userName.rawValue) as? String ?? ""
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: UserDefaultsKeys.userName.rawValue)
        }
    }
    
    var token: String {
        get {
            return UserDefaults.standard.value(forKey: UserDefaultsKeys.token.rawValue) as? String ?? ""
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: UserDefaultsKeys.token.rawValue)
        }
    }
    
    var email: String {
        get {
            return UserDefaults.standard.value(forKey: UserDefaultsKeys.email.rawValue) as? String ?? ""
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: UserDefaultsKeys.email.rawValue)
        }
    }
    
    var role: String {
        get {
            return UserDefaults.standard.value(forKey: UserDefaultsKeys.role.rawValue) as? String ?? ""
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: UserDefaultsKeys.role.rawValue)
        }
    }
    
    var apnsToken: String {
        get {
            return UserDefaults.standard.value(forKey: UserDefaultsKeys.apnsToken.rawValue) as? String ?? ""
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: UserDefaultsKeys.apnsToken.rawValue)
        }
    }
    
    var fcmToken: String {
        get {
            return UserDefaults.standard.value(forKey: UserDefaultsKeys.fcmToken.rawValue) as? String ?? ""
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: UserDefaultsKeys.fcmToken.rawValue)
        }
    }
    
    enum UserDefaultsKeys: String {
        case userName = "userName"
        case token = "access_token"
        case email = "email"
        case role = "role"
        case apnsToken = "apnsToken"
        case fcmToken = "fcmToken"
    }
}


