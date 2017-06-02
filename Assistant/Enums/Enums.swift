//
//  SaloonVendor
//
//  Created by Pratyush Pratik on 27/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

//MARK:- API Status Code
public enum APIStatusCode : Int {
    
    case success = 200
    case failure = 400
    case server = 500
    
    var rV : Int {
        return self.rawValue
    }
}

//MARK:- DataType
public enum DataType : String {
    
    case json = "json"
    case xml = "xml"
}

//MARK:- DataType
public enum TextResource : String {
    
    case countryCallingCode = "Country_Calling_Code"
    case orderTimes = "Order_Times"
}

//MARK:- SORT
public enum Sort : Int {
    
    case relevance = 1
    case lowestPrice = 2
    case highestPrice = 3
    case nearest = 4
    
    var rV : Int {
        return self.rawValue
    }
}

//MARK:- DATE FORMAT
public enum DateFormat : String {
    
    case ee = "EE"
    case utc = "yyyy-MM-dd'T'HH:mm:ssZ"
    case EEMMMMddyyyy = "EE MMMM dd,yyyy"
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case YYYYmmddHHiiss = "YYYY-mm-dd HH:mm:ss"
    case hhmmss = "HH:mm:ss"
    case yyyyMMdd = "yyyy-MM-dd"
    case mmddyyyy = "MM/dd/yyyy"
    case hhmm = "HH:mm"
    case hhmma = "hh:mm a"
    case hh = "HH"
    
    var rV : String {
        return self.rawValue
    }
}

//MARK:- FB PICTURE TYPE
public enum FbPictureType : String {
    
    case small = "small"
    case normal = "normal"
    case album = "album"
    case large = "large"
    case square = "square"
}

//MARK:- BUTTON TEXT
public enum ButtonText: String {
    
    case edit = "Edit"
    case done = "Done"
    
    var rV : String {
        return self.rawValue
    }
}

//MARK:- PROFILE ITEMS
public enum ProfileItems: String {
    
    case myProfessionals = "My Professionals"
    case mySubscription = "My Subscription"
    case help = "Help"
    case changePassword = "Change Password"
    case logout = "Logout"
    
    var rV : String {
        return self.rawValue
    }
}

//MARK:- SHOW WITH CANCEL AND OK
public enum ShowWithCancelAndOk: String {
    
    case logout = "Logout"
    case cancel = "Cancel"
    case areYouSureToLogout = "Are You Sure To Logout"
    
    var rV : String {
        return self.rawValue
    }
}

//MARK:- SEGMENT VIEW TITLE
public enum SegmentViewTitle: String {
    
    case services = "Services"
    case offers = "Offers"
    case reviews = "Reviews"
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
    
    var rV : String {
        return self.rawValue
    }
}

//MARK:- IDENTIFIER
public enum Identifier : String {
    
    case Fullname = "FullName"
    case HomeTitleText = "HomeTitleText"
    case Email = "Email"
    case Contact = "Contact"
    case Country = "Country"
    case State = "State"
    case About = "About"
    case Check = "Check"
    case Request = "Request"
    case English = "English_en"
    case Arabic = "Arabic_ar"
    case StoryBoardId = "Root_View"
    case imgName = "p2.jpg"
    case Warning = "languageChangedWarningMessage"
    case titleOk = "OK"
    case notificationChanged = "kNotificationLanguageChanged"
    case DeviceLanguage = "DeviceLanguage"
    case SaveLanguage = "kSaveLanguageDefaultKey"
    case Localizable = "Localizable"
    case Strings = "strings"
}

public enum RequestArgument: String {
    case service = "Service"
    case offer = "Offer"
    
    var rV : String {
        return self.rawValue
    }
}

public enum ActionKey: String {
    case cancel = "Cancel"
    case takePicture = "Take Picture"
    case gallery = "Gallery"
    case delete = "Delete"
    
    var rV : String {
        return self.rawValue
    }
}

public enum DescribingDayKey: String {
    case today = "Today"
    case tomorrow = "Tomorrow"
    case yesterday = "Yesterday"
    
    var rV : String {
        return self.rawValue
    }
}
