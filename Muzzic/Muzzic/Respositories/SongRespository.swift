//
//  SongRespository.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/11/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import Foundation
import ObjectMapper
protocol SongRespository {
    func getSongByGenre(genre: String, completion: @escaping (APIOutputBase<GetSongOutput>) -> Void)
}

class SongRespositoryImpl: SongRespository {
    static let sharedInstance = SongRespositoryImpl()
    fileprivate let apiService = APIService()
    func getSongByGenre(genre: String, completion: @escaping (APIOutputBase<GetSongOutput>) -> Void) {
        let input = GetSongInput(genre: genre)
        apiService.request(input: input) { (data: [GetSongOutput]?, error) in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(error: error))
            }
        }
    }
}
