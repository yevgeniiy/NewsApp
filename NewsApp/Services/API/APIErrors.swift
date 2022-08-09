//
//  HttpErrors.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 30.07.2022.
//

import Foundation

enum APIErrors: Error {
    case invalidPath
    case badRequest
    case badResponse
    case unknownError
}

extension APIErrors: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidPath:
            return "Invalid path."
        case .badRequest:
            return "Bad request."
        case .badResponse:
            return "Bad response."
        default:
            return "Unknown error."
        }
    }
}
