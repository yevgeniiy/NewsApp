//
//  ArticlesSourceView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 10.08.2022.
//

import SwiftUI

struct ArticlesSourceView: View {
    
    @State var source: SourceResponse

    @ObservedObject private var vm = ArticlesSourceViewModel()
    @State private var searchText: String = ""
    
    private var trimmedSearchText: String { searchText.trimmingCharacters(in: .whitespacesAndNewlines)}
    
    @EnvironmentObject private var errorHandling: ErrorHandling
    
    var body: some View {
        List {
            ForEach(vm.articles, id: \.id) { article in
                NewsRowView(article: article)
                    .onAppear {
                        if article == vm.articles.last {
                            vm.loadMore(source: self.source, searchText: self.trimmedSearchText)
                        }
                    }
            }
        }
        .listStyle(.inset)
        .overlay {
            if case .loading = vm.loadingState {
                ProgressView()
            } else if vm.articles.isEmpty {
                EmptyNewsView()
            }
        }
        .navigationTitle(self.source.name)
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            vm.searchArticle(searchText: trimmedSearchText, source: self.source, page: 1)
        }
        .onChange(of: trimmedSearchText) { newValue in
            if newValue.isEmpty {
                vm.updateView(source: self.source)
            } else {
                vm.articles.removeAll()
                vm.searchArticle(searchText: newValue, source: self.source, page: 1)
            }
        }
        .refreshable {
            vm.updateView(source: self.source)
        }
        .onAppear {
            vm.updateView(source: self.source)
        }
        
    }
}

struct ArticlesSourceView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesSourceView(source: SourceResponse(id: "abc-news", name: "ABC News", description: "", url: "https://abcnews.go.com", category: "general", language: "en", country: "us"))
    }
}
