//
//  SaloonVendor
//
//  Created by Pratyush Pratik on 27/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import Foundation
import SwiftMessages

class SwiftMessageAlert: NSObject {
    
    static let shared = SwiftMessageAlert()
    
    func show(alert title : String , message : String , layout : MessageView.Layout = .CardView, theme : Theme = .success, isbuttonHidden : Bool = true,presentationStyle : SwiftMessages.PresentationStyle = .top){
        
        let alert = MessageView.viewFromNib(layout: layout)
        alert.configureTheme(theme)
        alert.configureDropShadow()
        alert.configureContent(title: title, body: message)
        alert.button?.isHidden = isbuttonHidden
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = presentationStyle
        successConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        SwiftMessages.show(config: successConfig, view: alert)
        
    }
}
