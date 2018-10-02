//
//  Constants.swift
//  NotificationDemo
//
//  Created by ONGRAPH_PC on 30/09/18.
//  Copyright © 2018 ONGRAPH_PC. All rights reserved.
//

import Foundation

// MARK: - Constants
let kPasswordCharacterCount = 3
let kOK = "OK"
let kCell = "Cell"

// MARK: - Alerts
let kAlertTitle = "Dairy Farm Manager"
let kAlertPasswordCount = "Password must contain more than \(kPasswordCharacterCount) characters"
let kAlertSomethingWentWrong = "Something went wrong. Please try again later!"
let kAlertInvalidNumber = "Invalid Number Entered"
let kAlertInvalidEmail = "Please enter valid email address."
let kAlertBlankFields = "All Fields are mandatory."
let kAlertPasswordNotMatched = "Passwords not matching. Please check the passwords."
let kAlertInvalidCredentials = "Incorrect credentials"
let kAlertEmailAlreadyExists = "Email already exists with us. Please try with different email"
let kAlertContinueToSubscription = "Continue to monthly subscription?"
let kAlertCancel = "Cancel"

// MARK: - URLs
enum APIConfiguration: String {
    case baseURL = "https://boiling-atoll-18288.herokuapp.com"
    case login = "/auth/login"
    case signUp = "/admin/signup"
    case animalRegistration = "/livestock/registeration"
    case getAnimals = "//livestock/getAnimals"
    case getTypeData = "//livestock/0/getTypeData"
    case registerDevice = "/registerDevice"
}
