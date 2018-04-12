//
//  APIService.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/11/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//
import UIKit
import Alamofire
import ObjectMapper

class APIService {
    static let sharedInstance = APIService()
    fileprivate var manager = Alamofire.SessionManager.default

    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.timeoutIntervalForResource = 15
        manager = Alamofire.SessionManager(configuration: config)
    }

    func request<T: Mappable>(input: APIInputBase, completion: @escaping (_ value: [T]?, _ error: APIError?) -> Void) {
        print(input.description)

        manager.request(input.urlString,
                        method: input.requestType,
                        parameters: input.parameters,
                        encoding: input.encoding,
                        headers: input.headers)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 200 {
                            let jsonData = response.data
                            if let json = try? JSONSerialization
                                .jsonObject(with: jsonData!, options: []) as? [[String: Any]] {
                                    let data = Mapper<T>().mapArray(JSONArray: json!)
                                    completion(data, nil)
                            }
                        } else {
                            if let error = Mapper<ResponseMessage>().map(JSONObject: value) {
                                completion(nil, APIError.serverError(error: error))
                            } else {
                                completion(nil, APIError.httpError(httpCode: statusCode))
                            }
                        }
                    } else {
                        completion(nil, APIError.unexpectedErr)
                    }
                case .failure(let error):
                    completion(nil, error as? APIError)
                }
        }

    }
}
