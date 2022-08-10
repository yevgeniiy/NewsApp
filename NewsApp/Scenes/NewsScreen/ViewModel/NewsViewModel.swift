//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 10.08.2022.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    
    @Published var articles:[ArticlesData] = []
    
    @Published var loadingState:LoadingState = .loading
    
    private var nextPage: Int = 1
    
    enum LoadingState {
        case articles
        case searshing
        case loading
    }
    
    func loadMore(searchText: String?) {
        switch loadingState {
        case .articles:
            getArticles(page: nextPage)
        case .searshing:
            searchArticle(searchText: searchText ?? "", page: nextPage)
        case .loading:
            return
        }
    }
    
    func searchArticle(searchText: String, page: Int) {
        guard !searchText.isEmpty else { return }
        
        self.loadingState = .loading
        Task {
            do {
                let newArticles = try await NewsAPI.shared.getData(from: .searchArticle(searchString: searchText, page: String(page))).articles ?? []
                self.articles.append(contentsOf: newArticles)
                nextPage += 1
                self.loadingState = .searshing
            } catch {
                ErrorHandling.shared.handle(error: error)
            }
        }
    }
    
    func getArticles(page:Int) {
        self.loadingState = .loading
        Task {
            do {
                let newArticles = try await NewsAPI.shared.getData(from: .getTopHeadlines(page:String(page))).articles ?? []
                self.articles.append(contentsOf: newArticles)
                nextPage += 1
                self.loadingState = .articles
            } catch {
                ErrorHandling.shared.handle(error: error)
            }
        }
    }
    
    func updateView() {
        self.articles.removeAll()
        self.nextPage = 1
        getArticles(page: 1)
        
    }
    
}
