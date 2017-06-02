//
//  UIViewExtension.swift
//  SaloonVendor
//
//  Created by Pratyush Pratik on 07/04/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//MARK:- MODULES
import Foundation
import UIKit

//MARK:- UITEXTFIELD
extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

//MARK:- UIVIEW
extension UIView {
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)),
        mask = CAShapeLayer()
        
        mask.path = path.cgPath
        self.layer.mask = mask
        self.layer.masksToBounds=true
    }
    
    func roundCornerWithBorder(cornerRadius : CGFloat = 5.0,maskToBound : Bool = true,borderWidth : CGFloat = 0.5,borderColor : UIColor = UIColor.black) {
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = maskToBound
        self.layer.borderWidth = borderWidth
        self.layer.borderColor =  borderColor.cgColor
    }
    
    func toCircle() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
//    @IBInspectable var _borderColor: UIColor? {
//        get {
//            return UIColor(cgColor: layer.borderColor!)
//        }
//        set {
//            self.layer.borderColor = _borderColor?.cgColor
//        }
//    }
    func borderColor(color : UIColor) {
        self.layer.borderColor = color.cgColor
    }
    
    func cornerRadius(cornerRadius : CGFloat) {
        self.layer.cornerRadius = cornerRadius
    }
    
    func masksToBounds(maskToBound : Bool) {
        self.layer.masksToBounds = maskToBound
    }
    
    func borderWidth(borderWidth : CGFloat) {
        self.layer.borderWidth = borderWidth
    }
    
    func removeBorder() {
        self.layer.borderWidth = 0.0
    }
    
    func shadowEffet() {
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero;
        self.layer.shadowOpacity = 0.5
    }
    
    func backgroundFade(alpha : CGFloat = 0.3) {
        self.backgroundColor = UIColor.black.withAlphaComponent(alpha)
    }
    
    func fadeIn(withDuration duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(withDuration duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
    func viewAnimationEnabled(_bool: Bool) {
        UIView.setAnimationsEnabled(_bool)
    }
    
    func addTapToDismissView() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissViewOnTap))
        self.addGestureRecognizer(tap)
    }
    
    func dismissViewOnTap() {
        self.fadeOut(withDuration: 0.5)
    }
    
    func animateHide() {
        
        let animationDuration = 0.35
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.transform = self.transform.scaledBy(x: 0.001, y: 0.001)
        }) { (completion) -> Void in
            self.removeFromSuperview()
        }
    }
    
    func animateShow(view : UIView) {
        
        let animationDuration = 0.35
        self.addSubview(view)
        view.transform = view.transform.scaledBy(x: 0.001, y: 0.001)
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            view.transform = CGAffineTransform.identity
        })
    }
}

extension UIView {
    
    /**
     Rounds the given set of corners to the specified radius
     
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    func round(corners: UIRectCorner, radius: CGFloat) {
        _round(corners: corners, radius: radius)
    }
    
    /**
     Rounds the given set of corners to the specified radius with a border
     
     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
     
     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func fullyRound(diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = diameter / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor;
    }
    
}

private extension UIView {
    
    @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}

//MARK: - UITABLEVIEWCELL
extension UITableViewCell {
    
    func initialSetUp() {
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
        self.contentView.backgroundColor = UIColor.white
        self.backgroundView = nil
        self.selectedBackgroundView = nil;
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
}

//MARK: - UIIMAGEVIEW
extension UIImageView {
    
    func toData() -> Data? {
        if let image = self.image {
            let data = UIImagePNGRepresentation(image)
            return data
        }
        return nil
    }
}

//MARK:- UIIMAGE
extension UIImage {
    
    class func outlinedEllipse(size: CGSize, color: UIColor, lineWidth: CGFloat = 0.5) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth * 0.5, dy: lineWidth * 0.5)
        context.addEllipse(in: rect)
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    enum Quality: CGFloat {
        
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    var pngData: Data? { return UIImagePNGRepresentation(self) }
    
    func jpegData(_ quality: Quality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
    
    @discardableResult func toBase64() -> String{
        let imageData = UIImagePNGRepresentation(self)
        return /imageData?.base64EncodedString(options: .lineLength64Characters)
    }
    
    @discardableResult func toBase76() -> String{
        let imageData = UIImagePNGRepresentation(self)
        return /imageData?.base64EncodedString(options: .lineLength76Characters)
    }
}

//MARK:- UILABEL
extension UILabel {
    
    func set(html : String) {
        do {
            guard let htmlData = html.data(using: String.Encoding.utf8) else { return }
            self.attributedText = try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            self.adjustsFontSizeToFitWidth = true
            self.lineBreakMode = .byTruncatingTail
        }
        catch {
            print("Unable to parse label text: \(error)")
        }
    }
}

//MARK:- STRING
extension String {
    
    subscript(pos: Int) -> String {
        precondition(pos >= 0, "character position can't be negative")
        return self[pos...pos]
    }
    subscript(range: Range<Int>) -> String {
        precondition(range.lowerBound >= 0, "range lowerBound can't be negative")
        let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex) ?? endIndex
        return self[lowerIndex..<(index(lowerIndex, offsetBy: range.count, limitedBy: endIndex) ?? endIndex)]
    }
    subscript(range: ClosedRange<Int>) -> String {
        precondition(range.lowerBound >= 0, "range lowerBound can't be negative")
        let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex) ?? endIndex
        return self[lowerIndex..<(index(lowerIndex, offsetBy: range.count, limitedBy: endIndex) ?? endIndex)]
    }
    
    var length: Int {
        return self.characters.count
    }
    
    
    @discardableResult func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    @discardableResult func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    var localized: String {
        return  NSLocalizedString(self, comment: "")
    }
    
    @discardableResult func localized(with comment : String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
    
    @discardableResult func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    var trim : String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    @discardableResult func replace(target: String, with newString: String) -> String {
        return self.replacingOccurrences(of: target, with: newString, options: CompareOptions.literal, range: nil)
    }
    
    var toCommaSeperatedArray : [String] {
        let arr = self.components(separatedBy: ",")
        return arr
    }
    
    func split(from : String) -> [String] {
        let array = self.components(separatedBy: from)
        return array
    }
    
    var toJson : AnyObject? {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if let jsonData = data {
            do {    // Will return an object or nil if JSON decoding fails
                let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
                return message as AnyObject? //Will return the json array output
            }
            catch let error as NSError {
                print("An error occurred: \(error)")
                return nil
            }
        }
        else { return nil  } // Lossless conversion of the string was not possible
    }
    
    func convertTo(roundedDouble numberOfPlaces : Int) -> Double {
        guard let strDbl = Double(self) else { return 0.0}
        let numberOfPlaces = Double(numberOfPlaces)
        let multiplier = pow(10.0, numberOfPlaces)
        let rounded = round(strDbl * multiplier) / multiplier
        return rounded
    }
    
    func toUrl() -> URL?{
        return URL(string: self)
    }
    
    var toBool : Bool? {
        return self.lowercased() == "true" || self.lowercased() == "1"
    }
    
    var decodeFromUTF8Encoding : String? {
        return self.removingPercentEncoding
    }
}

extension Double {
    
    var showPrice : String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value : self))
    }
}

//MARK: - NSMUTABLEATTRIBUTEDSTRING
extension NSMutableAttributedString {
    func bold(_ text:String) -> NSMutableAttributedString {
        let attrs  = [NSFontAttributeName : UIFont(name: "Montserrat-Light", size: 30) ?? UIFont.boldSystemFont(ofSize: 30.0)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func normal(_ text:String) -> NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}

//MARK:- INT
extension Int {
    
    func toBool () ->Bool? {
        return self == 1
    }
    
    private func formatType(form: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    var dateFull: Date {
        return Date(timeIntervalSince1970: Double(self))
    }
    var toHour: String {
        return formatType(form: DateFormat.hh.rawValue).string(from: dateFull)
    }
    var toDay: String {
        return formatType(form: DateFormat.mmddyyyy.rawValue).string(from: dateFull)
    }
}

//MARK:- BOOL
extension Bool {
    
    var toString : String? {
        switch self {
        case true : return "true".localized
        case false: return "false".localized
        }
    }
}

//MARK:- DATA
extension Data {
    
    func convertToImage() -> UIImage? {
        let image = UIImage(data: self)
        return image
    }
}

//MARK:- UICOLOR
extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init(hex: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if hex.hasPrefix("#") {
            let index   = hex.index(hex.startIndex, offsetBy: 1)
            let hex     = hex.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                }
            }
            else {
                print("Scan hex error")
            }
        }
        else {
            print("Invalid RGB string, missing '#' as prefix", terminator: "")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    var lighter: UIColor {
        return lighterColor(removeSaturation: 0.5, resultAlpha: -1)
    }
    
    func lighterColor(removeSaturation val: CGFloat, resultAlpha alpha: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0
        var b: CGFloat = 0, a: CGFloat = 0
        
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a)
            else {return self}
        
        return UIColor(hue: h,
                       saturation: max(s - val, 0.0),
                       brightness: b,
                       alpha: alpha == -1 ? a : alpha)
    }
}

//MARK:- UISEARCHBAR
extension UISearchBar {
    
    func change(textFont : UIFont?) {
        for view : UIView in (self.subviews[0]).subviews {
            if let textField = view as? UITextField {
                textField.font = textFont
            }
        }
    }
}

import CoreLocation

//MARK:- CORELOCATION
extension CLLocationCoordinate2D {
    
    var toString : (latitude : String,longitude : String) {
        let latStr = String(self.latitude)
        let longStr = String(self.longitude)
        return (latStr,longStr)
    }
    
    var toCLLocation : CLLocation {
        let lat: CLLocationDegrees = self.latitude
        let long: CLLocationDegrees = self.longitude
        let location = CLLocation(latitude: lat, longitude: long)
        return location
    }
}
