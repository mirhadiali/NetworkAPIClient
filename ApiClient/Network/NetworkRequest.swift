//
//  NetworkRequest.swift
//  ApiClient
//
//  Created by Hadi on 02/10/2021.
//

import Foundation
import Alamofire

enum Result<T> {
    case success(T)
    case failure(Error)
}

class NetworkRequest {
    static func callAPI<ResponseModel : Decodable>(request: URLRequestConvertible, showLoader: Bool = true, onSuccess successBlock: ((ResponseModel) -> Void)?, onFailure failureBlock: ((Error, Bool) -> Void)? = nil, castTo: ResponseModel.Type) {
        AF.request(request).responseDecodable(of: castTo.self) { (response) in
            /// Handle failure closure
            let handleFailure: (_: Parameters, _: Any, _: Error) -> Void = { errorDictionary, log, error in
                var isNetworkError = false
                if let error = error as NSError?, error.code == NSURLErrorNotConnectedToInternet {
                    isNetworkError = true
                    // Show network error message
//                    Helper.showMessage(text: Constants.APIError.network)
                }
                // Execute failure closure
                failureBlock?(error, isNetworkError)
            }
            
            switch response.result {
            case .success(let value):
                // Check if response contains a dictionary
                successBlock?(value)
                // Checking Webservice API failure response codes
            case .failure(let error):
                // Execute failure closure handler
                if error.localizedDescription.contains("Software caused connection abort") {
                    callAPI(request: request, onSuccess: successBlock, onFailure: failureBlock, castTo: castTo)
                } else {
                    handleFailure(["message": error.localizedDescription], "APIErrorLogMessage".localized, error)
                }
            }
        }
    }
    
    static func decodeJSONResponse<T: Decodable>(data: Parameters, castTo: T.Type) -> T? {
        var json: Data!
        do {
            json = try JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
            print("Extension JSONSerialized", json)
            do {
                return try JSONDecoder().decode(T.self, from: json)
            } catch {
                print("Error: \(error.localizedDescription)")
                return nil
            }
        } catch {
            print(error)
            return nil
        }
    }
}
