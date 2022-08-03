//
//  NewsView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 31.07.2022.
//

import SwiftUI

struct NewsView: View {
    
    @ObservedObject private var vm = ViewModel()
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            NewsListView(articles: vm.articles)
            .overlay {
                if vm.isLoading {
                    ProgressView()
                } else if vm.articles.isEmpty {
                    EmptyNewsView()
                }
            }
            .navigationTitle("News")
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                Task { await vm.searchArticles(from: searchText) }
            }
            .onChange(of: searchText) { searchQuery in
                Task { await vm.searchArticles(from: searchQuery) }
            }
            .refreshable {
                Task { await vm.fetchAllArticles() }
            }
            .task {
                await vm.fetchAllArticles()
            }
            .alert(vm.errorMessage, isPresented: $vm.showErrorAlert) {
                Button("Ok", role: .cancel) {}
            }
            
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
