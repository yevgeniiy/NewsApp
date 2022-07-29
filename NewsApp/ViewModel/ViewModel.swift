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
    @Published var hasError = false
    @Published var error: String?
    
    private let apiKey = "API"
    

    func fetchAllArticles() {
        fetchArticles(from: buildNewsURL())
    }
    
    func searchArticles(from searchText: String) {
        fetchArticles(from: buildSearchURL(from: searchText))
    }
    
    private func fetchArticles(from url: URL ) {
        
        // Create a URLsession
        let session = URLSession(configuration: .default)

        // Give the session a task
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let safeData = data {
                    do {
                        let results = try decoder.decode(NewsApiResponse.self, from: safeData)
                        // Update must happen on the main thread, not in the background
                        DispatchQueue.main.async {
                            self.articles = results.articles ?? []
                        }
                    } catch {
                        self.generateError(error: error)
                    }
                }
            } else {
                self.generateError(error: error)
            }
        }

        // Start the task
        task.resume()
        
    }
    
    private func buildSearchURL(from searchText: String) -> URL {
        let searchQuery = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let baseURL = "https://newsapi.org/v2/top-headlines?"
        let urlString = "\(baseURL)apiKey=\(self.apiKey)&language=en&q=\(searchQuery)"
        if let url = URL(string: urlString) {
            return url
        } else {
            return buildNewsURL()
        }

        
    }
    
    private func buildNewsURL() -> URL {
        let baseURL = "https://newsapi.org/v2/top-headlines?"
        let urlString = "\(baseURL)apiKey=\(self.apiKey)&language=en"
        let url = URL(string: urlString)!
        return url
    }
    
    private func generateError(error:Error?) {
        self.hasError = true
        if error != nil {
            self.error = error?.localizedDescription
        } else {
            self.error = "Unknown error"
        }

        
    }

}
