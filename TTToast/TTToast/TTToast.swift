//
//  TTToast.swift
//  TTToast
//
// Copyright (c) 2015 Tatsuya Tanaka
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE

import Foundation
import UIKit

@objc(TTToast) public class Toast: UIView {
    
    public enum Position: UInt32 {
        case Middle = 1
        case Top = 2
        case Bottom = 4
        case Left = 8
        case Right = 16
    }
    
    @objc(TTToastConfig) public class Config: NSObject {
        // Appearance
        public var maxWidth = CGFloat(0.8)
        public var paddingHorizontal = CGFloat(10.0)
        public var paddingVertical = CGFloat(10.0)
        public var cornerRadius = CGFloat(8)
        public var alpha = CGFloat(0.9)
        public var font = UIFont(name: "HiraKakuProN-W6", size: 15.0)
        public var textColor = UIColor.whiteColor()
        public var backgroundColor = UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0)
        
        // Shadow
        public var shadow = false
        public var shadowOpacity = Float(0.8)
        public var shadowRadius = CGFloat(5.0)
        public var shadowOffset = CGSizeMake(4.0, 4.0)
        public var shadowColor = UIColor.grayColor().CGColor
        
        // Duration
        public var durationBefore = 1.0
        public var duration = 1.3
        public var durationAfter = 1.0
        
        // Position
        public var position = Position.Middle.rawValue
        
        
        func duplicate() -> Config {
            let newInstance = Config()
            newInstance.maxWidth = config.maxWidth
            newInstance.paddingHorizontal = config.paddingHorizontal
            newInstance.paddingVertical = config.paddingVertical
            newInstance.cornerRadius = config.cornerRadius
            newInstance.alpha = config.alpha
            newInstance.font = config.font
            newInstance.textColor = config.textColor
            newInstance.backgroundColor = config.backgroundColor
            
            newInstance.shadow = config.shadow
            newInstance.shadowOpacity = config.shadowOpacity
            newInstance.shadowRadius = config.shadowRadius
            newInstance.shadowOffset = config.shadowOffset
            newInstance.shadowColor = config.shadowColor
            
            newInstance.durationBefore = config.durationBefore
            newInstance.duration = config.duration
            newInstance.durationAfter = config.durationAfter
            
            newInstance.position = config.position
            return newInstance
        }
    }
    
    static var config = Config()
    private var _config = config.duplicate()
    
    private func setup(message: String, parent: UIView) {
        self.backgroundColor = _config.backgroundColor
        self.alpha = _config.alpha
        self.clipsToBounds = true
        self.layer.cornerRadius = _config.cornerRadius
        if _config.shadow {
            self.layer.masksToBounds = false
            self.layer.shadowOpacity = _config.shadowOpacity
            self.layer.shadowRadius = _config.shadowRadius
            self.layer.shadowOffset = _config.shadowOffset
            self.layer.shadowColor = _config.shadowColor
        }
        
        let rect = parent.frame
        let msgLabel = UILabel(frame: CGRectMake(0, 0, rect.width * _config.maxWidth, rect.height))
        msgLabel.text = message
        msgLabel.textColor = _config.textColor
        msgLabel.font = _config.font
        msgLabel.numberOfLines = 0
        msgLabel.sizeToFit()
        self.addSubview(msgLabel)
        
        let size = CGSizeMake(  msgLabel.frame.width + _config.paddingHorizontal * 2,
                                msgLabel.frame.height + _config.paddingVertical * 2)
        self.frame = CGRectMake(0, 0, size.width, size.height)
        
        self.center = CGPointMake(rect.width / 2, rect.height / 2)
        if _config.position & Position.Top.rawValue != 0 {
            self.frame.origin.y = 0
        }
        else if _config.position & Position.Bottom.rawValue != 0 {
            self.frame.origin.y = rect.height - self.frame.height
        }
        if _config.position & Position.Left.rawValue != 0 {
            self.frame.origin.x = 0
        }
        else if (_config.position & Position.Right.rawValue != 0) {
            self.frame.origin.x = rect.width - self.frame.width
        }
        
        msgLabel.center = parent.convertPoint(self.center, toView: self)
    }
    
// MARK: - shows
    
    public class func show(message: String) {
        self.show(message, view: topView())
    }
    
    public class func show(message: String, view: UIView) {
        show(message, view:view, config: { _ in })
    }
    
    public class func show(message: String, config: (Config) -> Void) {
        show(message, view: topView(), config: config)
    }
    
    public class func show(message: String, view: UIView, config: (Config) -> Void) {
        for subview in view.subviews {
            if subview is Toast {
                subview.removeFromSuperview()
            }
        }
        
        let toast = Toast()
        config(toast._config)
        view.addSubview(toast)
        view.bringSubviewToFront(toast)
        toast.setup(message, parent: view)
        
        toast.fadeInOut()
    }
    
    private class func topView() -> UIView {
        var window = UIApplication.sharedApplication().keyWindow
        if (window == nil) {
            window = UIApplication.sharedApplication().windows[0]
        }
        var viewController = window?.rootViewController
        while (viewController!.presentedViewController != nil) {
            viewController = viewController!.presentedViewController;
        }
        return viewController!.view
    }
    
// MARK: - animations
    
    private func fadeInOut() {
        self.alpha = 0;
        UIView.animateWithDuration(_config.durationBefore, animations: { () -> Void in
            self.alpha = 1.0
        }) { (finished) -> Void in
            UIView.animateWithDuration(self._config.durationAfter, delay: self._config.duration,
                options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.alpha = 0
            }, completion: { (finished) -> Void in
                self.removeFromSuperview()
            })
        }
    }
}
