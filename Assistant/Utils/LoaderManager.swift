//
//  LoaderManager.swift
//
//  Created by Pratyush Pratik on 09/02/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class LoaderManager {
    
    static let shared : LoaderManager = {
        let instance = LoaderManager()
        return instance
    }()
    
    private var hud : NVActivityIndicatorView?
    private var background = UIView()
    private let width = 60.0
    private let height = 60.0
    private let cornerRadius : CGFloat = 10.0
    private let animateDuration = 0.2
    private let animationDelay = 0.0
    private var isShowingHud = false
    private let leftMenuBlackView = CGRect(x: 0.0, y: 0.0, width: ScreenSize.width, height: ScreenSize.height)
    
    func addHUD(forView view : UIView?) {
        
        if !self.isShowingHud {
            
            self.isShowingHud = true
            let frame = CGRect(x: width/2, y: height/2, width: width, height: height)
            let hudColor = GlobalConstants.Color.warmPurple
            
            guard let validView = view else { return }
            DispatchQueue.main.async {
                
                self.hud = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballClipRotateMultiple, color: hudColor, padding: 0.0)
                self.hud?.center = validView.center
                self.hud?.cornerRadius(cornerRadius: self.cornerRadius)
                self.background = UIView(frame: self.leftMenuBlackView)
                self.background.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                
                UIView.animate(withDuration: self.animateDuration, delay: self.animationDelay, options: .curveEaseInOut, animations: {
                    
                    self.hud?.alpha = fullAlpha
                    self.background.alpha = fullAlpha
                    self.hud?.startAnimating()
                    validView.addSubview(self.background)
                    validView.addSubview(self.hud ?? UIView())
                    
                }, completion: { (isCompleted) in
                })
            }
        }
    }
    
    func hideHUD(forView view : UIView?) {
        
        guard let _ = view, isShowingHud else { return }
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: self.animateDuration, delay: self.animationDelay, options: .curveEaseInOut, animations: {
                self.hud?.alpha = zeroAlpha
                self.background.alpha = zeroAlpha
                
            }, completion: { (isCompleted) in
                self.hud?.stopAnimating()
                self.hud?.removeFromSuperview()
                self.background.removeFromSuperview()
                self.isShowingHud = false
            })
        }
    }
}
