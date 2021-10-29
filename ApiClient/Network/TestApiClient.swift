//
//  TestApiClient.swift
//  ApiClient
//
//  Created by Hadi on 02/10/2021.
//

import Foundation
import Alamofire

enum TestApiClient: URLRequestConvertible {
    static var baseURL = URL(string: "https://61587d915167ba00174bbb25.mockapi.io/api/v1/")
    
    case getUsers
    case getUserByID(id: Int)
    case getUserByParam(params: UserRequestModel)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getUsers, .getUserByID, .getUserByParam:
                return .get
            default:
                return .post
            }
        }
        
        /// Parameters for Webservice API request
        let params: Parameters? = {
            switch self {
            case .getUserByParam(let params):
                return params.dictionary
            default:
                return nil
            }
        }()
        
        /// API Endpoint
        let relativePath: String = {
            switch self {
            case .getUsers:
                return "users"
            case .getUserByID(let id):
                return "users/\(id)"
            case .getUserByParam:
                return "users"
            }
        }()
        
        // Complete URL
        let url: URL = {
            let url = URL(string: relativePath, relativeTo: TestApiClient.baseURL)
            return url!
        }()

        // Encode parameters
        let encoding: ParameterEncoding = {
            switch method {
            case .post, .put:
                return JSONEncoding()
            default:
                return URLEncoding()
            }
        }()
        
        // Request for URL
        var urlRequest = URLRequest(url: url)
        
        // Configuring HTTP method
        urlRequest.httpMethod = method.rawValue
        
        // Timeout interval for Webservice API request
        urlRequest.timeoutInterval = 30

        // Encoding parameters
        return try encoding.encode(urlRequest, with: params)
    }
    
    
}

