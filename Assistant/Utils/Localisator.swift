//
//  Localisator.swift
//
//  Created by Pratyush Pratik on 25/04/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import Foundation
import UIKit

let kNotificationLanguageChanged = NSNotification.Name(rawValue: Identifier.notificationChanged.rawValue)

func Localization(_ string:String) -> String{
    return Localisator.sharedInstance.localizedStringForKey(string)
}

func SetLanguage(_ language:String) -> Bool {
    return Localisator.sharedInstance.setLanguage(language)
}

class Localisator {
    
    private let userDefaults  = UserDefaults.standard
    private var availableLanguagesArray         = [Identifier.DeviceLanguage.rawValue, Identifier.English.rawValue, Identifier.Arabic.rawValue]
    private var dicoLocalisation:NSDictionary!
    private let kSaveLanguageDefaultKey = Identifier.SaveLanguage.rawValue
    var currentLanguage = Identifier.DeviceLanguage.rawValue
    
    var saveInUserDefaults:Bool {
        get {
            return (userDefaults.object(forKey: kSaveLanguageDefaultKey) != nil)
        }
        set {
            if newValue {
                userDefaults.set(currentLanguage, forKey: kSaveLanguageDefaultKey)
            } else {
                userDefaults.removeObject(forKey: kSaveLanguageDefaultKey)
            }
            userDefaults.synchronize()
        }
    }
    
    class var sharedInstance :Localisator {
        struct Singleton {
            static let instance = Localisator()
        }
        return Singleton.instance
    }
    
    init() {
        if let languageSaved = userDefaults.object(forKey: kSaveLanguageDefaultKey) as? String {
            if languageSaved != Identifier.DeviceLanguage.rawValue {
                _ = self.loadDictionaryForLanguage(languageSaved)
            }
        }
    }
    
    // MARK: - Public custom getter
    
    func getArrayAvailableLanguages() -> [String] {
        return availableLanguagesArray
    }
    
    fileprivate func loadDictionaryForLanguage(_ newLanguage:String) -> Bool {
        
        let arrayExt = newLanguage.components(separatedBy: "_")
        
        for ext in arrayExt {
            if let path = Bundle(for:object_getClass(self)).url(forResource: Identifier.Localizable.rawValue, withExtension: Identifier.Strings.rawValue, subdirectory: nil, localization: ext)?.path {
                if FileManager.default.fileExists(atPath: path) {
                    currentLanguage = newLanguage
                    dicoLocalisation = NSDictionary(contentsOfFile: path)
                    return true
                }
            }
        }
        return false
    }
    
    fileprivate func localizedStringForKey(_ key:String) -> String {
        
        if let dico = dicoLocalisation {
            if let localizedString = dico[key] as? String {
                return localizedString
            }  else {
                return key
            }
        } else {
            return NSLocalizedString(key, comment: key)
        }
    }
    
    fileprivate func setLanguage(_ newLanguage:String) -> Bool {
        
        if (newLanguage == currentLanguage) || !availableLanguagesArray.contains(newLanguage) {
            return false
        }
        
        if newLanguage == Identifier.DeviceLanguage.rawValue {
            currentLanguage = newLanguage
            dicoLocalisation = nil
            NotificationCenter.default.post(name: kNotificationLanguageChanged, object: nil)
            return true
        }
        else if loadDictionaryForLanguage(newLanguage) {
            NotificationCenter.default.post(name: kNotificationLanguageChanged, object: nil)
            if saveInUserDefaults {
                userDefaults.set(currentLanguage, forKey: kSaveLanguageDefaultKey)
                userDefaults.synchronize()
            }
            return true
        }
        return false
    }
}
