//
//  DeviceManager.swift
//
//  Created by Pratyush Pratik on 01/02/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

import Foundation
import UIKit

class DeviceManager {
    
    static let shared : DeviceManager = {
        let instance = DeviceManager()
        return instance
    }()
    var systemVersion : String {
        return UIDevice.current.systemVersion
    }
    var deviceName : String {
        return UIDevice.current.name
    }
    var deviceModel : String {
        return UIDevice.current.model
    }
    var systemName : String {
        return UIDevice.current.systemName
    }
    var deviceieOrientation : UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    var localizedModel : String {
        return UIDevice.current.localizedModel
    }
    var appVersion : String {
        let version = /(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)
        return "\(version)"
    }
    var appBuild : String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? ""
    }
    var appVersionBuild : String {
        let version = appVersion, build = appBuild
        return version == build ? "Version: \(version)" : "Version: \(version)(\(build))"
    }
    
    var appVersioning : String {
        let version = appVersion, build = appBuild
        return version == build ? "\(version)" : "\(version).\(build)"
    }
}

struct ScreenSize {
    
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}

struct DeviceType {
    
    static let isIphone4OrLess =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 568.0
    static let isIphone5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0
    static let isIphone6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667.0
    static let isIphone6Plus = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 736.0
    static let isIphone =  UIDevice.current.userInterfaceIdiom == .phone
    static let isIpad =  UIDevice.current.userInterfaceIdiom == .pad
}
