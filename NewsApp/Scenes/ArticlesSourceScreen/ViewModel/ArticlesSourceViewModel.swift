//
//  ArticlesSourceViewModel.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 10.08.2022.
//

import Foundation

@MainActor
final class ArticlesSourceViewModel: ObservableObject {
    
    @Published var articles: [ArticlesData] = []
    
    @Published var loadingState:LoadingState = .loading
    
    private var nextPage: Int = 1
    
    enum LoadingState {
        case articles
        case searshing
        case loading
    }
    
    func loadMore(source: SourceResponse, searchText: String?) {
        switch loadingState {
        case .articles:
            getArticles(source: source, page: nextPage)
        case .searshing:
            searchArticle(searchText: searchText ?? "", source: source, page: nextPage)
        case .loading:
            return
        }
    }
    
    func searchArticle(searchText: String, source: SourceResponse, page: Int?) {
        self.loadingState = .loading
        Task {
            do {
                let newArticles = try await NewsAPI.shared.getData(from: .searchArticleFromSource(searchString: searchText, source: source.id, page: String(page ?? 1))).articles ?? []
                self.articles.append(contentsOf: newArticles)
                nextPage += 1
                self.loadingState = .searshing
            } catch {
                ErrorHandling.shared.handle(error: error)
            }
        }
    }
    
    func getArticles(source: SourceResponse, page: Int?) {
        Task {
            do {
                let newArticles = try await NewsAPI.shared.getData(from: .getArticlesFromSource(source: source.id, page: String(page ?? 1))).articles ?? []
                self.articles.append(contentsOf: newArticles)
                nextPage += 1
                self.loadingState = .articles
            } catch {
                ErrorHandling.shared.handle(error: error)
            }
        }
    }
    
    func updateView(source: SourceResponse) {
        self.articles.removeAll()
        self.nextPage = 1
        getArticles(source: source, page: 1)
    }
    
}
