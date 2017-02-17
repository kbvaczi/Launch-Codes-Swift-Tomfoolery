//
//  LaunchCodeButton.swift
//  Launch Codes
//
//  Created by KENNETH VACZI on 8/22/16.
//  Copyright © 2016 KENNETH VACZI. All rights reserved.
//

import UIKit

class LaunchCodeButton: UIButton {
    
    var originPoint: CGPoint?
    var currentGuessPosition: Int?
    let animationDuration = 0.3
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.addTarget(nil, action: Selector(("guessButtonTap:")), for: UIControlEvents.touchUpInside)
        print("initializing button \(self.titleLabel?.text)")
    }
    
    public func moveToPoint(_ destinationPoint: CGPoint, destinationGuessPosition: Int) {
        if self.originPoint == nil {
            self.originPoint = self.frame.origin
        }
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.frame.origin = CGPoint(x: destinationPoint.x, y: destinationPoint.y)
        })
        currentGuessPosition = destinationGuessPosition
    }
    
    public func moveBackToOrigin () {
        if originPoint != nil {
            UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                self.frame.origin = self.originPoint!
            })
            currentGuessPosition = nil
        }
    }
    
    public func isAtOrigin() -> Bool {
        if self.originPoint == nil || self.originPoint == self.frame.origin {
            print("at origin")
            return true
        }
        print("not at origin")
        print(String(describing: self.originPoint))
        return false
    }
    
    public func label() -> String {
        if let text = self.titleLabel?.text {
            return text
        }
        return ""
    }
    
}
