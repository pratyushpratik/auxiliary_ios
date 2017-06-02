//
//  LocaleManager.swift
//
//  Created by Pratyush Pratik on 01/02/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

import Foundation

class LocaleManager {
    
    static let shared : LocaleManager = {
        let instance = LocaleManager()
        return instance
    }()
    
    private let locale : Locale = Locale.current
    
    var currencySymbol : String? {
        return  self.locale.currencySymbol
    }
    var currencyCode : String? {
        return self.locale.currencyCode
    }
    
    var countryCode : String {
        if let code = (self.locale as NSLocale).object(forKey: .countryCode) as? String {
            return code
        }
        return String()
    }
    
    var phoneCode : String {
        
        guard let filePath: String = Bundle.main.path(forResource : TextResource.countryCallingCode.rawValue, ofType: DataType.json.rawValue) else { return String() }
        let jsonData: NSData = NSData(contentsOfFile: filePath)!
        
        do {
            let jsonDict: [String : AnyObject] = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions()) as! [String: AnyObject]
            
            let code = jsonDict[countryCode] as! String
            return code
        }
        catch {
            print("country code error")
        }
        return String()
    }
}
