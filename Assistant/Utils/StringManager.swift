//  StringManager.swift
//
//  Created by Pratyush Pratik on 01/02/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

import Foundation

class StringManager {
    
    static let shared : StringManager = {
        let instance = StringManager()
        return instance
    }()
    
    func toDict(fromModel model : Any) -> [String : Any] {
        var dict = [String : Any]()
        let otherSelf = Mirror(reflecting: model)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
    
    func toJsonString(from dictionaryOrArray : Any?) -> String? {
        
        guard let validDictOrArray = dictionaryOrArray else { return nil }
        var jsonString = String()
        do {
            let arrJson = try JSONSerialization.data(withJSONObject: validDictOrArray, options: JSONSerialization.WritingOptions.prettyPrinted)
            jsonString = String(data: arrJson, encoding: String.Encoding.utf8) ?? ""
        }catch let error {
            print(error.localizedDescription)
        }
        return jsonString
    }
}
