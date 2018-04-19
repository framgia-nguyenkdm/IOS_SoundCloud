//
//  Song.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/10/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit
import ObjectMapper
class Song: NSObject, Mappable {
    var songID = 0
    var name = ""
    var downloadLink = ""
    var singer = ""
    var imageLink = ""
    var genre = ""
    var stream = ""

    init(songID: Int, name: String,
         downloadLink: String,
         singer: String,
         genre: String,
         imageLink: String,
         stream: String) {

        self.songID = songID
        self.name = name
        self.downloadLink = downloadLink
        self.singer = singer
        self.genre = genre
        self.imageLink = imageLink
        self.stream = stream
    }

    required init?(map: Map) {
        super.init()
        mapping(map: map)
    }

    func mapping(map: Map) {
        songID <- map["id"]
        name <- map["title"]
        downloadLink <- map["download_url"]
        genre <- map["genre"]
        stream <- map["stream_url"]
        singer <- map["user.username"]
        imageLink <- map["user.avatar_url"]
    }
}
