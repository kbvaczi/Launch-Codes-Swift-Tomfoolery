//
//  LaunchCodeButton.swift
//  Launch Codes
//
//  Created by KENNETH VACZI on 8/22/16.
//  Copyright © 2016 KENNETH VACZI. All rights reserved.
//

import UIKit

class LaunchCodeLabel: UILabel {
    
    var vacant: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("initializing label \(self.text)")
    }
    
}
