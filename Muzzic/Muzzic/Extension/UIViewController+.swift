//
//  UIViewController+.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/16/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import Foundation
import PKHUD
// MARK: - Alert
extension UIViewController {
    func showAlert(title: String, message: String, handler: @escaping (() -> Void)) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: handler)
        }
    }
}
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
