//
//  AuthInteractor.swift
//  ApiClient
//
//  Created by Hadi on 28/11/2021.
//

import Foundation

class AuthInteractor {
    static var shared = AuthInteractor.init()
    
    private init() {
    }
    
    func getUsers(callBack : @escaping ((_ response: Users?, _ error: String?) -> Void) ) {
       NetworkRequest.callAPI(request: RequestBuilder.getUsers, onSuccess: { (users) in
            callBack(users, nil)
        }, onFailure: { (error, isNetworkError) in
            callBack(nil, error.localizedDescription)
        }, castTo: Users.self)
 
    }
}
