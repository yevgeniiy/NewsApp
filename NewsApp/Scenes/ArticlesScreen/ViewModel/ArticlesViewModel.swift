//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 10.08.2022.
//

import Foundation



@MainActor
final class ArticlesViewModel: ObservableObject {
    
    @Published private(set) var articles:[ArticlesResponse] = []
    @Published private(set) var loadingState:LoadingState = .initial
    
    let paginator = ArticlesDataPaginator()
    
    private func fetchData(from endpoint: ApiEndpoint) async {
        do {
            loadingState = .initial
            self.articles.removeAll()
            let data = try await paginator.getFirstPage(from: endpoint)
            self.articles = data
            loadingState = .success
        } catch {
            ErrorHandling.shared.handle(error: error)
        }
    }
    
    func loadMore() async {
        guard loadingState == .success else { return }
        loadingState = .loading
        do {
            let data = try await paginator.getNextPage()
            self.articles.append(contentsOf: data)
            loadingState = .success
        } catch {
            ErrorHandling.shared.handle(error: error)
        }
    }
    
    func searchArticle(searchText: String) {
        if searchText.isEmpty {
            getArticles()
        } else {
            Task { await fetchData(from: .searchArticle(searchString: searchText)) }
        }
    }
    
    func getArticles() {
        Task {
            await fetchData(from: .getTopHeadlines)
        }
    }
    
    func refreshArticles() {
        Task {
            await fetchData(from: paginator.currentEndpoint)
        }
    }
    

}


