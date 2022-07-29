//
//  ViewModel.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 28.07.2022.
//

import SwiftUI
import Foundation

class ViewModel: ObservableObject {
    
    @Published var articles: [Articles] = []
    
    let service = NewsAPI()
    
    @MainActor
    func fetchAllArticles() async {
        do {
            self.articles = try await service.fetch(url: buildNewsURL(searchText: nil))
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func searchArticles(from searchText: String) async {
        do {
            self.articles = try await service.fetch(url: buildNewsURL(searchText: searchText))
        } catch {
            print(error)
        }
    }
    
    
    private func buildNewsURL(searchText: String?) -> URL {
        var url = APIConstants.baseURL
        url += "apiKey=\(APIConstants.apiKey)"
        url += "&language=en"
        if searchText != nil {
            let searchQuery = searchText!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            url += "&q=\(searchQuery)"
        }
        
        return URL(string: url)!
    }
    
}
