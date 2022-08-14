//
//  ArticlesDataPaginator.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 14.08.2022.
//

import Foundation

class ArticlesDataPaginator {
    
    var totalPages: Int = 1
    var currentPage: Int = 1
    
    var nextPage: Int { return currentPage + 1 }
    
    var currentEndpoint: ApiEndpoint = .getTopHeadlines
    
    func getFirstPage(from endpoint: ApiEndpoint) async throws -> [ArticlesResponse] {
        currentEndpoint = endpoint
        currentPage = 1
        let data = try await NewsAPI.shared.getData(from: endpoint, page: 1)
        self.totalPages = data.pages
        return data.articles ?? []
    }
    
    func getNextPage() async throws -> [ArticlesResponse] {
        guard nextPage <= totalPages else { return [] }
        let data = try await NewsAPI.shared.getData(from: currentEndpoint, page: nextPage)
        currentPage += 1
        return data.articles ?? []
    }
}
