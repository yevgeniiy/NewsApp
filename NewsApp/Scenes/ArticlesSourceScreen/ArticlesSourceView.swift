//
//  ArticlesSourceView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 10.08.2022.
//

import SwiftUI

struct ArticlesSourceView: View {
    
    @State var source: SourceResponse
    @State var articles: [ArticlesData] = []

    @State private var isLoading: Bool = true
    
    @EnvironmentObject private var errorHandling: ErrorHandling
    
    var body: some View {
        List {
            ForEach(articles, id: \.id) { article in
                NewsRowView(article: article)
            }
        }
        .listStyle(.inset)
        .overlay {
            if isLoading {
                ProgressView()
            } else if articles.isEmpty {
                EmptyNewsView()
            }
        }
        .navigationTitle(source.name)
        .refreshable {
            updateView()
        }
        .onAppear {
            updateView()
        }
        
    }
}

struct ArticlesSourceView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesSourceView(source: SourceResponse(id: "abc-news", name: "ABC News", description: "", url: "https://abcnews.go.com", category: "general", language: "en", country: "us"))
    }
}

extension ArticlesSourceView {
    
    private func updateView() {
        self.isLoading = true
        Task {
            do {
                self.articles = try await NewsAPI.shared.getData(from:.getArticlesFromSource(source: self.source.id)).articles ?? []
                self.isLoading = false
            } catch {
                errorHandling.handle(error: error)
            }
        }
    }
}
