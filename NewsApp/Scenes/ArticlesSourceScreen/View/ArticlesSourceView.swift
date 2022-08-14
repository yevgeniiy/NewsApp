//
//  ArticlesSourceView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 10.08.2022.
//

import SwiftUI

struct ArticlesSourceView: View {
    
    @State var source: SourceResponse
    
    @StateObject var vm = ArticlesSourceViewModel()
    @State private var searchText: String = ""
    
    private var trimmedSearchText: String { searchText.trimmingCharacters(in: .whitespacesAndNewlines)}
    
    var body: some View {
        ArticlesSourceList
            .overlay {
                if case .initial = vm.loadingState, vm.articles.isEmpty {
                    ProgressView()
                }
            }
            .navigationTitle(self.source.name)
            .searchable(text: $searchText)
            .onChange(of: trimmedSearchText) { newValue in
                vm.searchArticlesFromSource(source: source, searchText: trimmedSearchText)
            }
            .refreshable {
                vm.refreshArticles()
            }
            .onAppear {
                vm.getArticlesFromSource(source: source)
            }
        
    }
    
    var ArticlesSourceList: some View {
        List {
            ForEach(vm.articles, id: \.id) { article in
                ArticlesRowView(article: article)
                    .onAppear {
                        if article == vm.articles.last {
                            Task { await vm.loadMore() }
                        }
                    }
            }
            if case .success = vm.loadingState, vm.articles.isEmpty {
                ArticlesEmptyView()
            }
        }
        .buttonStyle(.plain)
        
    }
}

struct ArticlesSourceView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesSourceView(source: SourceResponse(id: "abc-news", name: "ABC News", description: "", url: "https://abcnews.go.com", category: "general", language: "en", country: "us"))
    }
}
