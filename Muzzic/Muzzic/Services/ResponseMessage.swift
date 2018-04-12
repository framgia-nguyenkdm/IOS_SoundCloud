//
//  ResponseMessage.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/11/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseMessage: Mappable {
    var code: String?
    var message: String?

    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
}
