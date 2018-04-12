//
//  APIService+Song.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/11/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - Get profile
class GetSongInput: APIInputBase {

    init(genre: String) {
        let params: [String: Any] = [
            "client_id": UserProfile.myClientID,
            "order": "hotness",
            "tags": genre,
            "limit": 8
        ]
        super.init(urlString: APIUrls.getMusic,
                   parameters: params,
                   requestType: .get)
    }
}
class GetSongOutput: Mappable {
    var songID = 0
    var name = ""
    var image = ""
    var singer = ""
    var genre = ""
    var stream = ""
    required init?(map: Map) {
        mapping(map: map)
    }
    func mapping(map: Map) {
        songID <- map["id"]
        name <- map["title"]
        image <- map["user.avatar_url"]
        genre <- map["genre"]
        stream <- map["stream_url"]
        singer <- map["user.username"]
    }
}
