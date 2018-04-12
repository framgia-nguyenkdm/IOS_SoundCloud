//
//  APIBase.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/11/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

// MARK: - Base Input
class APIInputBase {
    var headers = [
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
    ]
    var urlString = ""
    var requestType: HTTPMethod
    var encoding: ParameterEncoding
    var parameters: [String: Any]?

    var description: String {
        return [
            "🌎 \(requestType.rawValue) \(urlString)",
            "Parameters: \(String(describing: parameters))"
            ].joined(separator: "\n")
    }

    init(urlString: String, parameters: [String: Any]?, requestType: HTTPMethod) {
        self.urlString = urlString
        self.parameters = parameters
        self.requestType = requestType
        self.encoding = requestType == .get ? URLEncoding.default : JSONEncoding.default
    }
}

// MARK: - Base Output
enum APIOutputBase<T: Mappable> {
    case success([T]?)
    case failure(error: APIError?)
}

// MARK: - Base Error
enum APIError: Error {
    case networkError
    case httpError(httpCode: Int)
    case unexpectedErr
    case serverError(error: ResponseMessage?)

    var description: String {
        switch self {
        case .networkError:
            return "Network Error"
        case .httpError(let code):
            return  httpErrorDescription(httpCode: code)
        case .serverError(let errorResponse):
            if let message = errorResponse?.message {
                return message
            }
            return "There something error with server"
        case .unexpectedErr:
            return "Unexpected Error"
        }
    }

    private func httpErrorDescription(httpCode: Int) -> String {
        if (300...308).contains(httpCode) {
            // Redirection
            return "The link was transferred to a different URL."
        }
        if ( 400...451).contains(httpCode) {
            // Client error
            return "An error occurred on the application side. Please try again later!"
        }
        if (500...511).contains(httpCode) {
            // Server error
            return "A server error occurred. Please try again later!"
        }
        // Unofficial error
        return "An error occurred. Please try again later!"
    }
}
