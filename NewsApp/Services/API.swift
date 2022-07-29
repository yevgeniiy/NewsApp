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
        let (data, _) = try await session.data(from: url)
        let apiResponse = try JSONDecoder().decode(NewsApiResponse.self, from: data)
        return apiResponse.articles ?? []
        
    }
    
    
}

