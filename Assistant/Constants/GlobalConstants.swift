//
//  GlobalConstants.swift
//
//  Created by Pratyush Pratik on 01/02/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

//MARK:- MODULES
import Foundation
import UIKit

//MARK:- APP CONSTANTS
let zeroAlpha : CGFloat = 0.0
let fullAlpha : CGFloat = 1.0
let animationDuration = 0.5
let animationDelay = 0.0

struct GlobalConstants {
    
    //MARK:- TOKEN
    struct Token {
        static let facebookAppId = "400699026932311"
    }
    
    //MARK:- STRING CONSTANTS
    struct StringConstants {
        static let euro = " €"
        static let km = " km"
        static let m = " m"
        static let min = " min"
        static let perMin = "/min"
        static let kg = " kg"
        static let lbs = " lbs"
        static let cm = " cm"
        static let inches = " inches"
    }
    
    //MARK:- COLOR
    struct Color {
        static let white = UIColor.white
        static let switchColor = UIColor(hex: "#15b3a2")
        static let warmPurple = UIColor(hex: "#7f317a")
        static let black = UIColor(hex: "#2E2B2B")
        static let grey = UIColor(hex: "#D0D0D0")
        static let lightBlack = UIColor(hex: "#000000")
        static let yellow = UIColor(hex: "#ffc10d")
        static let greyishBrown = UIColor(hex: "#4c4c4c")
        static let lightPink = UIColor(red: 241/255, green: 232/255, blue: 240/255, alpha: 1)
    }
    
    //MARK:- FONT
    struct Font {
        static let avenirBook14 = UIFont(name: "Avenir-Book", size: 14.0)
        static let avenirLight14 = UIFont(name: "Avenir-Light", size: 14.0)
        static let avenirRoman16 = UIFont(name: "Avenir-Roman", size: 16.0)
        static let avenirRoman14 = UIFont(name: "Avenir-Roman", size: 14.0)
        static let avenirBook12 = UIFont(name: "Avenir-Book", size: 12.0)
        static let avenirLight18 = UIFont(name: "Avenir-Light", size: 18.0)
        static let avenirLight16 = UIFont(name: "Avenir-Light", size: 16.0)
        static let avenirHeavy20 = UIFont(name: "Avenir-Heavy", size: 20.0)
        static let avenirHeavy14 = UIFont(name: "Avenir-Heavy", size: 14.0)
        static let avenirHeavy18 = UIFont(name: "Avenir-Heavy", size: 18.0)
    }
    
    //MARK:- APP DETAILS
    struct AppDetails {
        static let appName = "Saloon Vendor"
        static let deviceType = "IOS"
        static let website = "http://www.google.com/"
    }
}
