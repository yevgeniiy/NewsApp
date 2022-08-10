//
//  NewsView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 31.07.2022.
//

import SwiftUI

struct NewsView: View {
    
    @ObservedObject private var vm = NewsViewModel()
    
    @State private var searchText: String = ""
    
    private var trimmedSearchText: String { searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    init() {
        vm.updateView()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.articles, id: \.id) { article in
                    NewsRowView(article: article)
                        .onAppear {
                            if article == vm.articles.last {
                                vm.loadMore(searchText: trimmedSearchText)
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
            .navigationTitle("News")
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                vm.searchArticle(searchText: trimmedSearchText, page: 1)
            }
            .onChange(of: trimmedSearchText) { newValue in
                if newValue.isEmpty {
                    vm.updateView()
                } else {
                    vm.articles.removeAll()
                    vm.searchArticle(searchText: newValue, page: 1)
                }
            }
            .refreshable {
                vm.updateView()
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

