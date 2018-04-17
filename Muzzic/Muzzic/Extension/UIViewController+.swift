//
//  UIViewController+.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/16/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import Foundation
import PKHUD

extension UIViewController {
    func showLoading() {
        DispatchQueue.main.async {
            HUD.show(HUDContentType.rotatingImage(#imageLiteral(resourceName: "icon_loading")))
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            HUD.hide(animated: true)
        }
    }
}
