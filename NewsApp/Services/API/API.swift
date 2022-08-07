//
//  API.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 29.07.2022.
//

import Foundation

struct NewsAPI {
    
    func fetch(url:URL) async throws -> [ArticlesData] {
        
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

extension NewsAPI {
    
    func topHeadlines() async throws -> [ArticlesData] {
        var urlString = APIConstants.topNewsURL
        urlString += "apiKey=\(APIConstants.apiKey)"
        urlString += "&language=\(UserSettings.newsLanguage.code)"
        let url = URL(string: urlString)!
        return try await self.fetch(url: url)
    }
    
    func search(searchText: String) async throws -> [ArticlesData] {
        let searchQuery = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        var urlString = APIConstants.baseURL
        urlString += "apiKey=\(APIConstants.apiKey)"
        urlString += "&language=\(UserSettings.newsLanguage.code)"
        urlString += "&q=\(searchQuery)"
        let url = URL(string: urlString)!
        return try await self.fetch(url: url)
    }
    
}

