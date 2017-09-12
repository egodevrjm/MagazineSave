//
//  RoundedButton.swift
//  Added functionality library
//
//  Created by Ryan Morrison on 09/09/2017.
//  Copyright © 2017 egoDev. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    override func awakeFromNib() {
        layer.cornerRadius = 7.0
        layer.masksToBounds = true
        backgroundColor = UIColor.blue
        alpha = 1.0
        setTitleColor(UIColor.white, for: .normal)
    }
    
    
}
