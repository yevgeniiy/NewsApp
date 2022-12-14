//
//  ArticlesSourceViewModel.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 13.08.2022.
//

import Foundation

@MainActor
final class ArticlesSourceViewModel: ObservableObject {
    
    @Published private(set) var articles:[ArticlesResponse] = []
    @Published private(set) var loadingState:LoadingState = .initial
    
    let paginator = ArticlesDataPaginator()
    
    private func fetchData(from endpoint: ApiEndpoint) async {
        loadingState = .initial
        do {
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
    
    func searchArticlesFromSource(source: SourceResponse, searchText: String) {
        if searchText.isEmpty {
            getArticlesFromSource(source: source)
        } else {
            Task { await fetchData(from: .searchArticleFromSource(searchString: searchText, source: source.id)) }
        }
    }
    
    func getArticlesFromSource(source: SourceResponse) {
        Task {
            await fetchData(from: .getArticlesFromSource(source: source.id))
        }
    }
    
    func refreshArticles() {
        Task {
            await fetchData(from: paginator.currentEndpoint)
        }
    }
}
