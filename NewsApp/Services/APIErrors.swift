//
//  HttpErrors.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 30.07.2022.
//

import Foundation

enum APIErrors: Error {
    case badResponse
    case unknownError
}

extension APIErrors: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .badResponse:
            return "Bad response."
        default:
            return "Unknown error."
        }
    }
}
