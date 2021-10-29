//
//  NetworkRequest.swift
//  ApiClient
//
//  Created by Hadi on 02/10/2021.
//

import Foundation
import Alamofire

class NetworkRequest {
     static func callAPI(request: URLRequestConvertible, showLoader: Bool = true, onSuccess successBlock: ((Parameters) -> Void)?, onFailure failureBlock: ((Parameters, Bool) -> Void)? = nil) -> DataRequest {
        AF.request(request).responseDecodable(of: User.self) { (response) in
            response.value
        }
        return AF.request(request).responseJSON { (response) in
            
            /// Handle failure closure
            let handleFailure: (_: Parameters, _: Any, _: Error?) -> Void = { errorDictionary, log, errorObject in
                var isNetworkError = false
                if let error = errorObject as NSError?, error.code == NSURLErrorNotConnectedToInternet {
                    isNetworkError = true
                    // Show network error message
//                    Helper.showMessage(text: Constants.APIError.network)
                }
                // Execute failure closure
                failureBlock?(errorDictionary, isNetworkError)
            }
            
            switch response.result {
            case .success(let value):
                // Check if response contains a dictionary
                guard let successDictionary = value as? Parameters else {
                    // Execute failure closure handler
                    
                    successBlock?(["data":value])
//                    handleFailure(["message": "APIErrorGeneral".localized], "APIErrorLogMessage".localized, nil)
                    return
                }
                // Checking Webservice API failure response codes
                if let code = successDictionary["status_code"] as? Int {
                    switch code {
                    case Constants.APIResponseCode.APIErrorCode.invalidJson.rawValue,
                         Constants.APIResponseCode.APIErrorCode.invalidDataProvided.rawValue:
                        
                        // Execute failure closure handler
                        handleFailure(successDictionary, "APIErrorLogMessage".localized, nil)
                    case Constants.APIResponseCode.APIErrorCode.unauthorized.rawValue:
                        //                        Helper.logoutUser()
                        break
                        
                    case Constants.APIResponseCode.APISuccessCode.ok.rawValue:
                        // Execute success closure if Webservice API success response code is found
                        successBlock?(successDictionary)
                    default:
                        // Execute failure closure handler
                        handleFailure(successDictionary, "APIErrorSomethingWentWrong".localized, nil)
                    }
                } else {
                    // Execute success closure if Webservice API response code is not found but contains dictionary
                    successBlock?(successDictionary)
                }
            case .failure(let error):
                // Execute failure closure handler
                if error.localizedDescription.contains("Software caused connection abort") {
                    _ = callAPI(request: request, onSuccess: successBlock, onFailure: failureBlock)
                } else {
                    handleFailure(["message": error.localizedDescription], "APIErrorLogMessage".localized, error)
                }
            }
        }
    }
    
    static func mapData<T: Decodable>(data: Parameters, castTo: T.Type) -> T? {
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
