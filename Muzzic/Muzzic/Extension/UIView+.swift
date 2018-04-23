//
//  UIView+.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/20/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit
@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
