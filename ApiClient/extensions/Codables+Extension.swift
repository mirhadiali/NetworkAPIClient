//
//  Codable Extension.swift
//  ApiClient
//
//  Created by Hadi on 02/10/2021.
//

import Foundation

extension Encodable {
    
    /// convert encodable model to dictionary (JSON)
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
