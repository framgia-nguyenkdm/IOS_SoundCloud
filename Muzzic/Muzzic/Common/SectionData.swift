//
//  SectionData.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/20/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import Foundation
struct SectionData {
    let title: String
    let data: [Song]

    var numberOfItems: Int {
        return data.count
    }
    init(title: String, data: [Song]) {
        self.title = title
        self.data = data
    }
}
