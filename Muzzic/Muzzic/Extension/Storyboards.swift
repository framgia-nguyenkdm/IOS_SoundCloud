//
//  Storyboards.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/10/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit
extension UIStoryboard {
    static func home() -> UIStoryboard {
        return UIStoryboard(name: "Home", bundle: nil)
    }
    static func tabbar() -> UIStoryboard {
        return UIStoryboard(name: "Tabbar", bundle: nil)
    }
    static func playlist() -> UIStoryboard {
        return UIStoryboard(name: "Playlist", bundle: nil)
    }
}
