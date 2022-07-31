//
//  API.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 29.07.2022.
//

import Foundation

struct NewsAPI {
    
    func fetch(url:URL) async throws -> [Articles] {
        
        let session = URLSession.shared
        let (data, response) = try await session.data(from: url)
        
        guard response is HTTPURLResponse else {
            throw APIErrors.badResponse
        }
        
        let apiResponse = try JSONDecoder().decode(NewsApiResponse.self, from: data)
        
        if apiResponse.status == "ok" {
            return apiResponse.articles ?? []
        } else if apiResponse.status == "error" {
            throw NSError(domain: "NewsAPI", code: 1, userInfo: [NSLocalizedDescriptionKey: apiResponse.message ?? "Unknown error."])
        } else {
            throw APIErrors.unknownError
        }
        
    }
    
    
}

