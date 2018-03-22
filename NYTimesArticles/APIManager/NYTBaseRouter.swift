//
//  NYTBaseRouter.swift
//  NYTimesArticles
//
//  Created by Soumen Das on 21/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import UIKit
import Alamofire

protocol APIConfiguration {
    var baseURL: String { get }
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
}

class NYTBaseRouter: URLRequestConvertible, APIConfiguration {
    init() {}
    var baseURL: String {
        return applicationBaseURL
    }
    var path: String {
        fatalError("\(#function) Must be overridden in subclass")
    }
    var method: Alamofire.HTTPMethod {
        fatalError("\(#function) Must be overridden in subclass")
    }
    func asURLRequest() throws -> URLRequest {
        let url = try applicationBaseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue(applicationAPIKey, forHTTPHeaderField: "api-key")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
}
