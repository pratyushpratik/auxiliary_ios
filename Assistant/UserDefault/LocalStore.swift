//
//  SaloonVendor
//
//  Created by Pratyush Pratik on 27/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//MARK:- MODULES
import Foundation

//MARK:- CLASS
class LocalStore {
    
    //MARK:- KEYS
    private enum Keys : CustomStringConvertible {
        
        case deviceToken
        case accessToken
        case vendor
        case other_data
        
        var description : String {
            
            switch self {
                
            case .deviceToken : return "DEVICETOKEN_SALOONVENDOR"
            case .accessToken : return "ACCESSTOKEN_SALOONVENDOR"
            case .vendor : return "VENDOR_SALOONVENDOR"
            case .other_data : return "OTHER_DATA_SALOONVENDOR"
            }
        }
    }
    
    static let shared = LocalStore()
    
    private static let userDefaults = UserDefaults.standard
    
    //MARK:- SETTER GETTER DELETE OF DEVICE TOKEN
    static var deviceToken : String? {
        get {
            return userDefaults.object(forKey: Keys.deviceToken.description) as? String
        }
        set{
            guard let value = newValue else {
                userDefaults.removeObject(forKey: Keys.deviceToken.description)
                return
            }
            userDefaults.set(value, forKey: Keys.deviceToken.description)
            userDefaults.synchronize()
        }
    }
    
    //MARK:- SETTER GETTER DELETE OF ACCESS TOKEN
    static var accessToken : String? {
        get {
            return userDefaults.object(forKey: Keys.accessToken.description) as? String
        }
        set{
            guard let value = newValue else {
                userDefaults.removeObject(forKey: Keys.accessToken.description)
                return
            }
            userDefaults.set(value, forKey: Keys.accessToken.description)
            userDefaults.synchronize()
        }
    }
    
    //MARK- SETTER GETTER DELETE OF VENDOR
    static var vendor : Vendor? {
        get {
            guard let savedItem =  userDefaults.object(forKey: Keys.vendor.description) else { return nil }
            guard let vendor = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? Vendor else { return nil}
            return vendor
        }
        set{
            guard let value = newValue else {
                userDefaults.removeObject(forKey: Keys.vendor.description)
                return
            }
            let item = NSKeyedArchiver.archivedData(withRootObject: value)
            userDefaults.set(item, forKey: Keys.vendor.description)
            userDefaults.synchronize()
        }
    }
    
    //MARK:- SETTER GETTER DELETE OF OTHER DATA
    static var otherDataResponse : OtherDataResponse? {
        get {
            guard let savedItem =  userDefaults.object(forKey: Keys.vendor.description) else { return nil }
            guard let otherDataResponse = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? OtherDataResponse else { return nil}
            return otherDataResponse
        }
        set{
            guard let value = newValue else {
                userDefaults.removeObject(forKey: Keys.other_data.description)
                return
            }
            let item = NSKeyedArchiver.archivedData(withRootObject: value)
            userDefaults.set(item, forKey: Keys.other_data.description)
            userDefaults.synchronize()
        }
    }
    

    //MARK:- Logout
    static func logout() {
        LocalStore.accessToken = nil
        LocalStore.vendor = nil
    }
}
