//
//  Song.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/10/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit
class Song: NSObject {
    var name = ""
    var image = ""
    var singer = ""
    init(name: String, image: String, singer: String) {
        self.name = name
        self.image = image
        self.singer = singer
    }
}
