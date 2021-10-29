//
//  Constants.swift
//  ApiClient
//
//  Created by Hadi on 02/10/2021.
//

import Foundation

struct Constants {
    
    struct APIResponseCode {
        enum APIErrorCode: Int {
            case invalidDataProvided    = 400
            case unauthorized           = 401
            case forbidden              = 403
            case notFound               = 404
            case conflict               = 409
            case invalidJson            = 422
            case internalServerError    = 500
            case nonServiceArea         = 800
            case outOfFence             = 1010
            case invalidTime            = 1016
            case pickupOutOfFence       = 1018
            case dropoffOutOfFence      = 1019
            case customerBlocked        = 1020
            case insufficientBalance    = 1028
            case TripStatusInvalid      = 1068
            case TripAlreadyRefunded    = 1069
            case NoCancelEntryInWallet  = 1071
        }
        
        enum APISuccessCode: Int {
            case ok     = 200
            case signup = 201
        }
        
    }
}

