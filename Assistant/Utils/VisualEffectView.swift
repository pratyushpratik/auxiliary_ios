//
//  VisualEffectView.swift
//  FanU
//
//  Created by Gurjit Singh on 08/08/16.
//  Copyright © 2016 Gurjit Singh. All rights reserved.
//

import UIKit

public class VisualEffectView: UIVisualEffectView {
    
    let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()
    
    /// Tint color.
    public var colorTint: UIColor {
        get { return _valueForKey(key: "colorTint") as! UIColor }
        set { _setValue(value: newValue, forKey: "colorTint") }
    }
    
    /// Tint color alpha.
    public var colorTintAlpha: CGFloat {
        get { return _valueForKey(key: "colorTintAlpha") as! CGFloat }
        set { _setValue(value: newValue as AnyObject, forKey: "colorTintAlpha") }
    }
    
    /// Blur radius.
    public var blurRadius: CGFloat {
        get { return _valueForKey(key: "blurRadius") as! CGFloat }
        set { _setValue(value: newValue as AnyObject, forKey: "blurRadius") }
    }
    
    /// Scale factor.
    public var scale: CGFloat {
        get { return _valueForKey(key: "scale") as! CGFloat }
        set { _setValue(value: newValue as AnyObject, forKey: "scale") }
    }
    
    // ["grayscaleTintLevel", "grayscaleTintAlpha", "lightenGrayscaleWithSourceOver", "colorTint", "colorTintAlpha", "colorBurnTintLevel", "colorBurnTintAlpha", "darkeningTintAlpha", "darkeningTintHue", "darkeningTintSaturation", "darkenWithSourceOver", "blurRadius", "saturationDeltaFactor", "scale", "zoom"]
    
}

extension VisualEffectView {
    
    func _valueForKey(key: String) -> AnyObject? {
        return blurEffect.value(forKeyPath: key) as AnyObject
    }
    
    func _setValue(value: AnyObject?, forKey key: String) {
        blurEffect.setValue(value, forKeyPath: key)
        self.effect = blurEffect
    }
}

extension VisualEffectView {
    
    func tint(color: UIColor, blurRadius: CGFloat, alpha: CGFloat) {
        self.colorTint = color
        self.colorTintAlpha = alpha
        self.blurRadius = blurRadius
        self.scale = 1
    }
}
