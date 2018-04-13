//
//  UIimageView+.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/12/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit
extension UIImageView {
    func loadImgFrom(urlLink: String) {
        self.contentMode = .scaleAspectFit
        if let url = URL(string: urlLink) {
            URLSession.shared.dataTask(with: url) { data, response, _ in
                guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let data = data,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async {
                    self.image = image
                }
                }.resume()
        }
    }
}
