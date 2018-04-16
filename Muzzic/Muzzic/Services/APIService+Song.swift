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

    init(pageWith genre: String) {
        let params: [String: Any] = [
            "client_id": UserProfile.myClientID,
            "order": "hotness",
            "genre": genre,
            "limit": 30,
            "linked_partitioning": 1
        ]
        super.init(urlString: APIUrls.getMusic,
                   parameters: params,
                   requestType: .get)
    }

    init(searchStr: String) {
        let params: [String: Any] = [
            "client_id": UserProfile.myClientID,
            "q": searchStr,
             "limit": 30
        ]
        super.init(urlString: APIUrls.getMusic,
                   parameters: params,
                   requestType: .get)
    }

    init(urlLink: String) {
        super.init(urlString: urlLink,
                   parameters: nil,
                   requestType: .get)
    }
}

class GetListSongOutput: Mappable {
    var nextPage: String?
    var collections = [Song]()

    public init?() {
    }

    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {

        nextPage <- map["next_href"]
        collections <- map["collection"]
    }
}

class GetSongOutput: Mappable {
    var songID = 0
    var name = ""
    var imageLink = ""
    var singer = ""
    var genre = ""
    var stream = ""

    required init?(map: Map) {

        mapping(map: map)
    }

    func mapping(map: Map) {

        songID <- map["id"]
        name <- map["title"]
        imageLink <- map["user.avatar_url"]
        genre <- map["genre"]
        stream <- map["stream_url"]
        singer <- map["user.username"]
    }
}
