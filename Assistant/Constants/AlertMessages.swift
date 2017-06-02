//
//  AlertMessages.swift
//  Saloon User
//
//  Created by Pratyush Pratik on 30/03/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

//MARK:- MODULES
import Foundation

//MARK:- ALERTMESSAGE
public struct AlertMessage {
    
    var error : String?
    var success : String?
    var noInternet  : String?
    
    init(by success : String?,error : String? =  ErrorMessage.somethingWentWrong, noInternet : String? = ErrorMessage.noInternet) {
        self.error = error
        self.success = success
        self.noInternet = noInternet
    }
    
    init() {
        error = ErrorMessage.somethingWentWrong
        success = nil
        noInternet = ErrorMessage.noInternet
    }
}

//MARK:- ALERT TITLE
public struct AlertTitle {
    
    var error : String?
    var success : String?
    var noInternet  : String?
    
    init(by success : String?,error : String? =  GlobalConstants.AppDetails.appName, noInternet : String? = GlobalConstants.AppDetails.appName) {
        self.error = error
        self.success = success
        self.noInternet = noInternet
    }
    
    init() {
        self.error = nil
        self.success = nil
        self.noInternet = nil
    }
}

//MARK:- MESSAGES
struct TitleForAlert {
    static let success = "success"
    static let oops = "oops"
    static let cancel = "cancel"
    static let error = "error"
}


//MARK:- MESSAGES
struct InformationMessage {
    static let requiredLocation = "Required Location"
}

//MARK:- SUCCESS MESSAGE
struct SuccessMessage {
}


//MARK:- ERROR MESSAGE
struct ErrorMessage {
    static let somethingWentWrong = "Something Went Wrong"
    static let noInternet = "No Internet"
    static let sessionExpired = "Session Expired"
}
