//
//  SlideMenuController.swift
//
//  Created by Pratyush Pratik on 23/07/15.
//  Copyright (c) 2015 Kennedia. All rights reserved.
//

import Foundation
import UIKit

public struct SlideMenuOptions {
    
    public static var leftViewWidth: CGFloat = 270.0
    public static var leftBezelWidth: CGFloat = 16.0
    public static var contentViewScale: CGFloat = 0.96
    public static var contentViewOpacity: CGFloat = 0.5
    public static var shadowOpacity: CGFloat = 0.0
    public static var shadowRadius: CGFloat = 0.0
    public static var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    public static var panFromBezel: Bool = true
    public static var animationDuration: CGFloat = 0.4
    public static var hideStatusBar: Bool = false
    public static var pointOfNoReturnWidth: CGFloat = 44.0
}

public class SlideMenuController: UIViewController, UIGestureRecognizerDelegate {
    
    public enum SlideAction {
        case Open
        case Close
    }
    
    public enum TrackAction {
        case TapOpen
        case TapClose
        case FlickOpen
        case FlickClose
    }
    
    struct PanInfo {
        var action: SlideAction
        var shouldBounce: Bool
        var velocity: CGFloat
    }
    
    var opacityView = UIView()
    var mainContainerView = UIView()
    var leftContainerView = UIView()
    var rightContainerView =  UIView()
    var mainViewController: UIViewController?
    var leftViewController: UIViewController?
    var leftPanGesture: UIPanGestureRecognizer?
    var leftTapGetsture: UITapGestureRecognizer?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public convenience init(mainViewController: UIViewController, leftMenuViewController: UIViewController) {
        self.init()
        self.mainViewController = mainViewController
        leftViewController = leftMenuViewController
        initView()
    }
    
    deinit { }
    
    func initView() {
        mainContainerView = UIView(frame: view.bounds)
        mainContainerView.backgroundColor = UIColor.clear
        mainContainerView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        view.insertSubview(mainContainerView, at: 0)
        
        var opacityframe: CGRect = view.bounds
        let opacityOffset: CGFloat = 0
        opacityframe.origin.y = opacityframe.origin.y + opacityOffset
        opacityframe.size.height = opacityframe.size.height - opacityOffset
        opacityView = UIView(frame: opacityframe)
        opacityView.backgroundColor = UIColor.black
        opacityView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        opacityView.layer.opacity = 0.0
        view.insertSubview(opacityView, at: 1)
        
        var leftFrame: CGRect = view.bounds
        leftFrame.size.width = SlideMenuOptions.leftViewWidth
        leftFrame.origin.x = leftMinOrigin();
        let leftOffset: CGFloat = 0
        leftFrame.origin.y = leftFrame.origin.y + leftOffset
        leftFrame.size.height = leftFrame.size.height - leftOffset
        leftContainerView = UIView(frame: leftFrame)
        leftContainerView.backgroundColor = UIColor.clear
        leftContainerView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        view.insertSubview(leftContainerView, at: 2)
        
        addLeftGestures()
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        mainContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        leftContainerView.isHidden = true
        rightContainerView.isHidden = true
        
        coordinator.animate(alongsideTransition: nil, completion: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.closeLeftNonAnimation()
            
            self.leftContainerView.isHidden = false
            self.rightContainerView.isHidden = false
            
            self.removeLeftGestures()
            
            self.addLeftGestures()
            
        })
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
    }
    
    public override func viewWillLayoutSubviews() {
        
        setUpViewController(targetView: mainContainerView, targetViewController: mainViewController)
        setUpViewController(targetView: leftContainerView, targetViewController: leftViewController)
    }
    
    public override func openLeft() {
        setOpenWindowLevel()
        
        leftViewController?.beginAppearanceTransition(isLeftHidden(), animated: true)
        openLeftWithVelocity(velocity: 0.0)
        
        track(trackAction: .TapOpen)
    }
    
    public override func closeLeft() {
        leftViewController?.beginAppearanceTransition(isLeftHidden(), animated: true)
        closeLeftWithVelocity(velocity: 0.0)
        setCloseWindowLebel()
    }
    
    public func addLeftGestures() {
        
        if (leftViewController != nil) {
            if leftPanGesture == nil {
                leftPanGesture = UIPanGestureRecognizer(target: self, action: #selector(SlideMenuController.handleLeftPanGesture(panGesture:)))
                leftPanGesture!.delegate = self
                view.addGestureRecognizer(leftPanGesture!)
            }
            
            if leftTapGetsture == nil {
                leftTapGetsture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.toggleLeft))
                leftTapGetsture!.delegate = self
                view.addGestureRecognizer(leftTapGetsture!)
            }
        }
    }
    
    public func removeLeftGestures() {
        
        if leftPanGesture != nil {
            view.removeGestureRecognizer(leftPanGesture!)
            leftPanGesture = nil
        }
        
        if leftTapGetsture != nil {
            view.removeGestureRecognizer(leftTapGetsture!)
            leftTapGetsture = nil
        }
    }
    
    public func isTagetViewController() -> Bool {
        // Function to determine the target ViewController
        // Please to override it if necessary
        return true
    }
    
    public func track(trackAction: TrackAction) {
        // function is for tracking
        // Please to override it if necessary
    }
    
    struct LeftPanState {
        static var frameAtStartOfPan: CGRect = CGRect.zero
        static var startPointOfPan: CGPoint = CGPoint.zero
        static var wasOpenAtStartOfPan: Bool = false
        static var wasHiddenAtStartOfPan: Bool = false
    }
    
    func handleLeftPanGesture(panGesture: UIPanGestureRecognizer) {
        
        if !isTagetViewController() {
            return
        }
        
        switch panGesture.state {
        case UIGestureRecognizerState.began:
            
            LeftPanState.frameAtStartOfPan = leftContainerView.frame
            LeftPanState.startPointOfPan = panGesture.location(in: view)
            LeftPanState.wasOpenAtStartOfPan = isLeftOpen()
            LeftPanState.wasHiddenAtStartOfPan = isLeftHidden()
            
            leftViewController?.beginAppearanceTransition(LeftPanState.wasHiddenAtStartOfPan, animated: true)
            
            setOpenWindowLevel()
        case UIGestureRecognizerState.changed:
            
            let translation: CGPoint = panGesture.translation(in: panGesture.view!)
            leftContainerView.frame = applyLeftTranslation(translation: translation, toFrame: LeftPanState.frameAtStartOfPan)
            
            applyLeftContentViewScale()
        case UIGestureRecognizerState.ended:
            
            let velocity:CGPoint = panGesture.velocity(in: panGesture.view)
            let panInfo: PanInfo = panLeftResultInfoForVelocity(velocity: velocity)
            
            if panInfo.action == .Open {
                if !LeftPanState.wasHiddenAtStartOfPan {
                    leftViewController?.beginAppearanceTransition(true, animated: true)
                }
                openLeftWithVelocity(velocity: panInfo.velocity)
                track(trackAction: .FlickOpen)
                
            } else {
                if LeftPanState.wasHiddenAtStartOfPan {
                    leftViewController?.beginAppearanceTransition(false, animated: true)
                }
                closeLeftWithVelocity(velocity: panInfo.velocity)
                setCloseWindowLebel()
                
                track(trackAction: .FlickClose)
            }
        default:
            break
        }
        
    }
    
    struct RightPanState {
        static var frameAtStartOfPan: CGRect = CGRect.zero
        static var startPointOfPan: CGPoint = CGPoint.zero
        static var wasOpenAtStartOfPan: Bool = false
        static var wasHiddenAtStartOfPan: Bool = false
    }
    
    public func openLeftWithVelocity(velocity: CGFloat) {
        
        // Status BG if exist change color
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let viewController = appDelegate.window!.rootViewController as! SlideMenuController
        if let stausView = viewController.view.viewWithTag(1000) {
            stausView.backgroundColor = UIColor(netHex: 0x0B1417)
        }
        
        let xOrigin: CGFloat = leftContainerView.frame.origin.x
        let finalXOrigin: CGFloat = 0.0
        
        var frame = leftContainerView.frame;
        frame.origin.x = finalXOrigin;
        
        var duration: TimeInterval = Double(SlideMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { [weak self]() -> Void in
            if let strongSelf = self {
                strongSelf.leftContainerView.frame = frame
                strongSelf.mainContainerView.frame.origin.x = strongSelf.leftContainerView.frame.size.width
                
                
            }
        }) { [weak self](Bool) -> Void in
            if let strongSelf = self {
                strongSelf.disableContentInteraction()
                strongSelf.leftViewController?.endAppearanceTransition()
            }
        }
    }
    
    public func closeLeftWithVelocity(velocity: CGFloat) {
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let viewController = appDelegate.window!.rootViewController as! SlideMenuController
        if let stausView = viewController.view.viewWithTag(1000) {
            stausView.backgroundColor = UIColor(netHex: 0xF60000)
        }
        
        let xOrigin: CGFloat = leftContainerView.frame.origin.x
        let finalXOrigin: CGFloat = leftMinOrigin()
        
        var frame: CGRect = leftContainerView.frame;
        frame.origin.x = finalXOrigin
        
        var duration: TimeInterval = Double(SlideMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(fabs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { [weak self]() -> Void in
            if let strongSelf = self {
                strongSelf.leftContainerView.frame = frame
                strongSelf.mainContainerView.frame.origin.x = 0;
                strongSelf.opacityView.layer.opacity = 0.0
                
            }
        }) { [weak self](Bool) -> Void in
            if let strongSelf = self {
                
                strongSelf.enableContentInteraction()
                strongSelf.leftViewController?.endAppearanceTransition()
            }
        }
    }
    
    public override func toggleLeft() {
        if isLeftOpen() {
            closeLeft()
            setCloseWindowLebel()
            // closeMenu
            
            track(trackAction: .TapClose)
        } else {
            openLeft()
        }
    }
    
    public func isLeftOpen() -> Bool {
        return leftContainerView.frame.origin.x == 0.0
    }
    
    public func isLeftHidden() -> Bool {
        return leftContainerView.frame.origin.x <= leftMinOrigin()
    }
    
    public func isRightHidden() -> Bool {
        return rightContainerView.frame.origin.x >= view.bounds.width
    }
    
    public func changeMainViewController(mainViewController: UIViewController,  close: Bool) {
        
        removeViewController(viewController: self.mainViewController)
        self.mainViewController = mainViewController
        setUpViewController(targetView: mainContainerView, targetViewController: mainViewController)
        if (close) {
            closeLeft()
        }
    }
    
    public func changeLeftViewController(leftViewController: UIViewController, closeLeft:Bool) {
        
        removeViewController(viewController: self.leftViewController)
        self.leftViewController = leftViewController
        setUpViewController(targetView: leftContainerView, targetViewController: leftViewController)
        if closeLeft {
            self.closeLeft()
        }
    }
    
    private func leftMinOrigin() -> CGFloat {
        return  -SlideMenuOptions.leftViewWidth
    }
    
    private func rightMinOrigin() -> CGFloat {
        return view.bounds.width
    }
    
    private func panLeftResultInfoForVelocity(velocity: CGPoint) -> PanInfo {
        
        let thresholdVelocity: CGFloat = 1000.0
        let pointOfNoReturn: CGFloat = CGFloat(floor(leftMinOrigin())) + SlideMenuOptions.pointOfNoReturnWidth
        let leftOrigin: CGFloat = leftContainerView.frame.origin.x
        
        var panInfo: PanInfo = PanInfo(action: .Close, shouldBounce: false, velocity: 0.0)
        
        panInfo.action = leftOrigin <= pointOfNoReturn ? .Close : .Open;
        
        if velocity.x >= thresholdVelocity {
            panInfo.action = .Open
            panInfo.velocity = velocity.x
        } else if velocity.x <= (-1.0 * thresholdVelocity) {
            panInfo.action = .Close
            panInfo.velocity = velocity.x
        }
        
        return panInfo
    }
    
    private func panRightResultInfoForVelocity(velocity: CGPoint) -> PanInfo {
        
        let thresholdVelocity: CGFloat = -1000.0
        let pointOfNoReturn: CGFloat = CGFloat(floor(view.bounds.width) - SlideMenuOptions.pointOfNoReturnWidth)
        let rightOrigin: CGFloat = rightContainerView.frame.origin.x
        
        var panInfo: PanInfo = PanInfo(action: .Close, shouldBounce: false, velocity: 0.0)
        
        panInfo.action = rightOrigin >= pointOfNoReturn ? .Close : .Open
        
        if velocity.x <= thresholdVelocity {
            panInfo.action = .Open
            panInfo.velocity = velocity.x
        } else if (velocity.x >= (-1.0 * thresholdVelocity)) {
            panInfo.action = .Close
            panInfo.velocity = velocity.x
        }
        
        return panInfo
    }
    
    private func applyLeftTranslation(translation: CGPoint, toFrame:CGRect) -> CGRect {
        
        var newOrigin: CGFloat = toFrame.origin.x
        newOrigin += translation.x
        
        let minOrigin: CGFloat = leftMinOrigin()
        let maxOrigin: CGFloat = 0.0
        var newFrame: CGRect = toFrame
        
        if newOrigin < minOrigin {
            newOrigin = minOrigin
        } else if newOrigin > maxOrigin {
            newOrigin = maxOrigin
        }
        
        newFrame.origin.x = newOrigin
        return newFrame
    }
    
    private func applyRightTranslation(translation: CGPoint, toFrame: CGRect) -> CGRect {
        
        var  newOrigin: CGFloat = toFrame.origin.x
        newOrigin += translation.x
        
        let minOrigin: CGFloat = rightMinOrigin()
        //        var maxOrigin: CGFloat = SlideMenuOptions.rightViewOverlapWidth
        let maxOrigin: CGFloat = rightMinOrigin() - rightContainerView.frame.size.width
        var newFrame: CGRect = toFrame
        
        if newOrigin > minOrigin {
            newOrigin = minOrigin
        } else if newOrigin < maxOrigin {
            newOrigin = maxOrigin
        }
        
        newFrame.origin.x = newOrigin
        return newFrame
    }
    
    private func getOpenedLeftRatio() -> CGFloat {
        
        let width: CGFloat = leftContainerView.frame.size.width
        let currentPosition: CGFloat = leftContainerView.frame.origin.x - leftMinOrigin()
        return currentPosition / width
    }
    
    private func getOpenedRightRatio() -> CGFloat {
        
        let width: CGFloat = rightContainerView.frame.size.width
        let currentPosition: CGFloat = rightContainerView.frame.origin.x
        return -(currentPosition - view.bounds.width) / width
    }
    
    private func applyLeftContentViewScale() {
        // var openedLeftRatio: CGFloat = getOpenedLeftRatio()
        
        mainContainerView.frame.origin.x = leftContainerView.frame.size.width + leftContainerView.frame.origin.x
        
    }
    
    private func disableContentInteraction() {
        mainContainerView.isUserInteractionEnabled = false
    }
    
    private func enableContentInteraction() {
        mainContainerView.isUserInteractionEnabled = true
    }
    
    private func setOpenWindowLevel() {
        if (SlideMenuOptions.hideStatusBar) {
            DispatchQueue.main.async(execute: {
                if let window = UIApplication.shared.keyWindow {
                    window.windowLevel = UIWindowLevelStatusBar + 1
                }
            })
        }
    }
    
    private func setCloseWindowLebel() {
        if (SlideMenuOptions.hideStatusBar) {
            DispatchQueue.main.async(execute: {
                if let window = UIApplication.shared.keyWindow {
                    window.windowLevel = UIWindowLevelNormal
                }
            })
        }
    }
    
    private func setUpViewController(targetView: UIView, targetViewController: UIViewController?) {
        if let viewController = targetViewController {
            addChildViewController(viewController)
            viewController.view.frame = targetView.bounds
            targetView.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
        }
    }
    
    private func removeViewController(viewController: UIViewController?) {
        if let _viewController = viewController {
            _viewController.willMove(toParentViewController: nil)
            _viewController.view.removeFromSuperview()
            _viewController.removeFromParentViewController()
        }
    }
    
    public func closeLeftNonAnimation() {
        
        setCloseWindowLebel()
        let finalXOrigin: CGFloat = leftMinOrigin()
        var frame: CGRect = leftContainerView.frame;
        frame.origin.x = finalXOrigin
        leftContainerView.frame = frame
        opacityView.layer.opacity = 0.0
        mainContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        enableContentInteraction()
    }
    
    
    
    /*********************** UIGestureRecognizerDelegate *****************************/
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        let point: CGPoint = touch.location(in: view)
        if gestureRecognizer == leftPanGesture {
            return slideLeftForGestureRecognizer(gesture: gestureRecognizer, point: point)
        } else if gestureRecognizer == leftTapGetsture {
            return isLeftOpen() && !isPointContainedWithinLeftRect(point: point)
        }
        return true
    }
    
    private func slideLeftForGestureRecognizer( gesture: UIGestureRecognizer, point:CGPoint) -> Bool{
        return isLeftOpen() || SlideMenuOptions.panFromBezel && isLeftPointContainedWithinBezelRect(point: point)
    }
    
    private func isLeftPointContainedWithinBezelRect(point: CGPoint) -> Bool{
        var leftBezelRect: CGRect = CGRect.zero
        var tempRect : CGRect = CGRect.zero
        let bezelWidth: CGFloat = SlideMenuOptions.leftBezelWidth
        (leftBezelRect, tempRect) = view.bounds.divided(atDistance: bezelWidth, from: .minXEdge)
        return leftBezelRect.contains(point)
    }
    
    private func isPointContainedWithinLeftRect(point: CGPoint) -> Bool {
        return leftContainerView.frame.contains(point)
    }
    
    private func isPointContainedWithinRightRect(point: CGPoint) -> Bool {
        return rightContainerView.frame.contains(point)
    }
}

extension UIViewController {
    
    public func slideMenuController() -> SlideMenuController? {
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is SlideMenuController {
                return viewController as? SlideMenuController
            }
            viewController = viewController?.parent
        }
        return nil;
    }
    
    public func toggleLeft() {
        slideMenuController()?.toggleLeft()
    }
    
    public func openLeft() {
        slideMenuController()?.openLeft()
    }
    
    public func closeLeft() {
        slideMenuController()?.closeLeft()
    }
    
    /****** Please specify if you want menu gesuture give priority to than targetScrollView ****/
    public func addPriorityToMenuGesuture(targetScrollView: UIScrollView) {
        if let slideControlelr = slideMenuController() {
            let recognizers =  slideControlelr.view.gestureRecognizers
            for recognizer in (recognizers! as [UIGestureRecognizer]) {
                if recognizer is UIPanGestureRecognizer {
                    targetScrollView.panGestureRecognizer.require(toFail: recognizer)
                }
            }
        }
    }
}
