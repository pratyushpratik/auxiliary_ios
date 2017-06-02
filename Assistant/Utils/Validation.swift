//
//  ValidationClass.swift
//  BusinessDirectory
//
//  Created by Pratyush Pratik on 04/01/17.
//  Copyright © 2017 Taran. All rights reserved.
//

//MARK:- MODULES
import UIKit

//MARK:- ENUM
enum Alerts : String{
    case success = "Success"
    case oops = "Oops"
    case login = "Login Successfull"
    case ok = "Ok"
    case cancel = "Cancel"
    case error = "Error"
}

enum Valid{
    case success
    case failure(Alerts,String)
}

//MARK:- CLASS
class Validation: NSObject {
    
    static let shared = Validation()
    
    //validate Login
    func validateLogin(username : String? , password : String?) -> Valid {
        
        if (/username).isEmpty {
            return errorMsg(str: "Please enter email")
        }
        else if !isValidEmail(testStr:/username) {
            return errorMsg(str: "Please enter valid email")
        }
        else if (/password).isEmpty {
            return errorMsg(str: "Please enter password")
        }
        else if !isValidLength(testStr: /password, len1: 7, len2: 100) {
            return errorMsg(str: "Password length should be greater than 7")
        }
        return .success
    }
    
    //validate SignUp
    func validateSignUp(name : String? , address : String?, phoneNumber : String? , email : String?, password: String?) -> Valid {
        
        if (/name).isEmpty {
            return errorMsg(str: "Please enter name")
        }
        else if !isValidAlphabet(testStr: /name) {
            return errorMsg(str: "Please enter valid name")
        }
        else if (/address).isEmpty {
            return errorMsg(str: "Please enter address")
        }
        else if (/phoneNumber).isEmpty {
            return errorMsg(str: "Please enter phone number")
        }
        else if !isValidNumber(testStr: /phoneNumber) {
            return errorMsg(str: "Please enter valid phone number")
        }
        else if !isValidLength(testStr: /phoneNumber, len1: 10, len2: 10) {
            return errorMsg(str: "Phone Number should be equal to 10")
        }
        else if (/email).isEmpty {
            return errorMsg(str: "Please enter email")
        }
        else if !isValidEmail(testStr:/email) {
            return errorMsg(str: "Please enter valid email")
        }
        else if (/password).isEmpty {
            return errorMsg(str: "Please enter password")
        }
        else if !isValidLength(testStr: /password, len1: 7, len2: 100) {
            return errorMsg(str: "Password length should be greater than 7")
        }
        return .success
    }
    
    func validateForgetPassword(email: String?) -> Valid {
        
        if (/email).isEmpty {
            return errorMsg(str: "Please enter email")
        }
        else if !isValidEmail(testStr: /email) {
            return errorMsg(str: "Please enter valid email")
        }
        return .success
    }
    
    //validate UpdateProfile
    func validateUpdateProfile(name : String? , address : String?, phoneNumber : String? , email : String?,workExperience : String?) -> Valid {
        
        if (/name).isEmpty {
            return errorMsg(str: "Please enter name")
        }
        else if !isValidAlphabet(testStr: /name) {
            return errorMsg(str: "Please enter valid name")
        }
        else if (/address).isEmpty {
            return errorMsg(str: "Please enter address")
        }
        else if (/phoneNumber).isEmpty {
            return errorMsg(str: "Please enter phone number")
        }
        else if !isValidNumber(testStr: /phoneNumber) {
            return errorMsg(str: "Please enter valid phone number")
        }
        else if !isValidLength(testStr: /phoneNumber, len1: 10, len2: 10) {
            return errorMsg(str: "Phone Number should be equal to 10")
        }
        else if (/email).isEmpty {
            return errorMsg(str: "Please enter email")
        }
        else if !isValidEmail(testStr:/email) {
            return errorMsg(str: "Please enter valid email")
        }
        else if (/workExperience).isEmpty {
            return errorMsg(str: "Please enter workExperience")
        }
        return .success
    }
    
    func isValidPasswordUpdate(oldPassword: String?, newPassword: String?, confirmPassword: String?) -> Valid {
        
        if (/oldPassword).isEmpty {
            return errorMsg(str: "Please enter old password")
        }
        else if !isValidLength(testStr: /oldPassword, len1: 7, len2: 100) {
            return errorMsg(str: "Password length should be greater than 7")
        }
        else if (/newPassword).isEmpty {
            return errorMsg(str: "Please enter new password")
        }
        else if !isValidLength(testStr: /newPassword, len1: 7, len2: 100) {
            return errorMsg(str: "Password length should be greater than 7")
        }
        else if (/confirmPassword).isEmpty {
            return errorMsg(str: "Please enter confirm password")
        }
        else if !isValidLength(testStr: /confirmPassword, len1: 7, len2: 100) {
            return errorMsg(str: "Password length should be greater than 7")
        }
        else if !isSamePassword(password: /newPassword, confirmPassword: /confirmPassword){
            return errorMsg(str: "Password is not same")
        }
        return .success
    }
    
    func isValidAddServices(startDt: String?, endDt: String?, category: String?, subCategory: String?, duration: String?, price: String?) -> Valid {
        
        if (/startDt).isEmpty {
            return errorMsg(str: "Please enter Start Date")
        }
        else if (/endDt).isEmpty {
            return errorMsg(str: "Please enter End Date")
        }
        else if (/category).isEmpty {
            return errorMsg(str: "Please enter category")
        }
        else if (/subCategory).isEmpty {
            return errorMsg(str: "Please enter subCategory")
        }
        else if (/duration).isEmpty {
            return errorMsg(str: "Please enter duration")
        }
        else if !isValidNumber(testStr: /duration) {
            return errorMsg(str: "Please enter valid duration")
        }
        else if !checkTextFieldValue(str: /duration, min: 0, max: 1441) {
            return errorMsg(str: "Duration can't be less than 0, or greater than 1440")
        }
        else if (/price).isEmpty {
            return errorMsg(str: "Please enter price")
        }
        else if !checkTextFieldValue(str: /price, min: 0, max: 10000) {
            return errorMsg(str: "Price can't be less than 0, or greater than 10000")
        }
        else if !isValidNumber(testStr: /price) {
            return errorMsg(str: "Please enter valid price")
        }
        return .success
    }
    
    //validate professional
    func validateProfessional(name : String? , description : String?) -> Valid {
        
        if (/name).isEmpty {
            return errorMsg(str: "Please enter name")
        }
        else if !isValidAlphabet(testStr:/name) {
            return errorMsg(str: "Please enter valid name")
        }
        else if (/description).isEmpty {
            return errorMsg(str: "Please enter description")
        }
        else if !isValidAlphabet(testStr:/description) {
            return errorMsg(str: "Please enter valid description")
        }
        return .success
    }
    
    //error message
    func errorMsg(str : String) -> Valid {
        return .failure(.error,str)
    }
    
    //email validation
    func isValidEmail(testStr:String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: testStr)
    }
    
    //length validation
    func isValidLength(testStr: String, len1: Int, len2: Int) -> Bool {
        if testStr.characters.count >= len1 && testStr.characters.count <= len2 { return true }
        else { return false }
    }
    
    //alphabet validation
    func isValidAlphabet(testStr: String) -> Bool {
        let regEx = "[a-zA-Z][a-zA-Z ]+[a-zA-Z]$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: testStr)
    }
    
    //alphabet validation
    func isValidNumber(testStr: String) -> Bool {
        let regEx = "^[0-9]*$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: testStr)
    }
    
    //same password validation
    func isSamePassword(password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword { return true }
        else { return false }
    }
    
    //textfield check
    func checkTextFieldValue(str: String, min: Int, max: Int) -> Bool {
        if /Int(str) > min && /Int(str) < max { return true }
        else { return false }
    }
}
