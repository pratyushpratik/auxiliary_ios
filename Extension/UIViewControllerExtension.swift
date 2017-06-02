//
//  Extension.swift
//  SaloonVendor
//
//  Created by Pratyush Pratik  on 27/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//MARK:- MODULES
import UIKit
import Foundation

//MARK:- EXTENSION
extension UIViewController {
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        self.view.addSubview(toastLabel)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func addTapToHideKeyboard() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnViewTap))
        self.view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboardOnViewTap() {
        self.view.endEditing(true)
    }
    
    func moveBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func moveBackToRoot() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func dismissController() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    var appDelegate : AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func addHUD() {
        LoaderManager.shared.addHUD(forView: self.view)
    }
    
    func hideHUD() {
        LoaderManager.shared.hideHUD(forView: self.view)
    }
    
    func viewAnimationEnabled(_bool: Bool) {
        UIView.setAnimationsEnabled(_bool)
    }
    
    func tableViewAnimationEnables(_bool: Bool) {
        UITableView.setAnimationsEnabled(_bool)
    }
    
    func logout() {
        
        LocalStore.logout()
        let loginVC = StoryboardScene.Main.instantiateLoginViewController()
        let nvc: UINavigationController = UINavigationController(rootViewController: loginVC)
        nvc.isNavigationBarHidden = true
        appDelegate?.window?.rootViewController = nvc
    }
    
    func loginCheckToMoveHome() {
        if let _ = LocalStore.vendor {
            let vc = StoryboardScene.Home.instantiateHomeTabBarViewController()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }

    func showAlertToEnablePush() {
        
        Alert().showWithCancelAndOk(title: "enablePush".localized, okTitle: "settings".localized, cancelTitle: "cancel".localized, message: "pleaseEnablePush".localized, viewController: self, okAction: {
            
            guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, completionHandler: { (isCompleted) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        })
    }
}


//MARK:- IBACTION
extension UIViewController {
    
    //btnActionBack
    @IBAction func btnActionBack(_ sender: UIButton) {
        moveBack()
    }
}

//MARK:- FUNCTION
extension UIViewController {
    
    //instantiate
    class func instantiate(fromStoryboard name: String, id: String) -> Self? {
        return instantiateHelper(fromStoryboard: name, id: id)
    }
    
    //instantiateHelper
    private class func instantiateHelper<T>(fromStoryboard name: String, id: String) -> T? {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: id) as? T
        return controller
    }
}
