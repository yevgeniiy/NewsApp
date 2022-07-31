//
//  ViewModel.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 28.07.2022.
//

import SwiftUI
import Foundation

class ViewModel: ObservableObject {
    
    let newsAPI = NewsAPI()
    
    @Published var articles: [Articles] = []
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    
    @MainActor
    func fetchAllArticles() async {
        refreshState()
        do {
            self.articles = try await newsAPI.fetch(url: buildNewsURL(searchText: nil))
        } catch {
            showError(error: error)
        }
    }
    
    @MainActor
    func searchArticles(from searchText: String) async {
        refreshState()
        do {
            self.articles = try await newsAPI.fetch(url: buildNewsURL(searchText: searchText))
        } catch {
            showError(error: error)
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
    
    private func showError(error: Error) {
        self.showErrorAlert = true
        self.errorMessage = error.localizedDescription
        
    }
    
    private func refreshState() {
        self.showErrorAlert = false
        self.errorMessage = ""
    }
    
}
