//
//  NewsView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 31.07.2022.
//

import SwiftUI

struct NewsView: View {
    
    @State private var articles: [ArticlesData] = []
    
    @State private var _searchText: String = ""
    @State private var isLoading: Bool = true
    
    @EnvironmentObject private var errorHandling: ErrorHandling
    
    private var searchText: String {
        get {
            return self._searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    var body: some View {
        NavigationView {
            NewsListView(articles: articles)
                .overlay {
                    if isLoading {
                        ProgressView()
                    } else if articles.isEmpty {
                        EmptyNewsView()
                    }
                }
                .navigationTitle("News")
                .searchable(text: $_searchText)
                .onSubmit(of: .search) {
                    searchArticle(searchText: searchText)
                }
                .onChange(of: searchText) { newValue in
                    if newValue.isEmpty {
                        updateView()
                    } else {
                        searchArticle(searchText: newValue)
                    }
                }
                .refreshable {
                        updateView()
                }
                .onAppear {
                    if searchText.isEmpty {
                        updateView()
                    }
                }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

extension NewsView {
    
    private func searchArticle(searchText: String) {
        self.isLoading = true
        Task {
            do {
                self.articles = try await NewsAPI.shared.getData(from: .searchArticle(searchString: searchText)).articles ?? []
                self.isLoading = false
            } catch {
                errorHandling.handle(error: error)
            }
        }
    }
    
    private func updateView() {
        self.articles.removeAll()
        self.isLoading = true
        Task {
            do {
                self.articles = try await NewsAPI.shared.getData(from: .getTopHeadlines).articles ?? []
                self.isLoading = false
            } catch {
                errorHandling.handle(error: error)
            }
        }
    }
}

