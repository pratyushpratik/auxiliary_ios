//
//  SaloonVendor
//
//  Created by Pratyush Pratik on 27/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//MARK:- MODULES
import Foundation
import UIKit

//MARK:- CLASS
class Alert {
    
    static let shared = Alert()
    
    var okAction : AlertSuccess?
    typealias AlertSuccess = (()->())?
    
    /*********************************** show **********************************/
    public func show(title : String?, message : String?, viewController : UIViewController?, okAction : AlertSuccess = nil) {
        
        let version : NSString = UIDevice.current.systemVersion as NSString
        if  version.doubleValue >= 8 {
            let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { (action: UIAlertAction) in
                
                if let okAction = okAction {
                    okAction()
                }
            }))
            viewController?.present(alert, animated:true, completion:nil);
        }
    }
    
    /****************************** showWithCancelAndOk ***********************************/
    public func showWithCancelAndOk(title : String, okTitle : String, cancelTitle : String, message : String, viewController : UIViewController?, okAction : AlertSuccess = nil, cancelAction : AlertSuccess = nil) {
        let version:NSString = UIDevice.current.systemVersion as NSString;
        
        if  version.doubleValue >= 8 {
            let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle:.alert)
            
            alert.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: { (action: UIAlertAction) in
                
                if let cancelAction = cancelAction {
                    cancelAction()
                }
            }))
            alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (action: UIAlertAction) in
                
                if let okAction = okAction {
                    okAction()
                }
            }))
            viewController?.present(alert, animated:true, completion:nil);
        }
    }
}
