//
//  String+Extensions.swift
//  ApiClient
//
//  Created by Hadi on 02/10/2021.
//

import Foundation

// MARK: - String extension

extension String {
    
    /// get strings from localized files
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
