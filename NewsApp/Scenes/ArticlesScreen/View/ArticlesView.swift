//
//  NewsView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 31.07.2022.
//

import SwiftUI

struct ArticlesView: View {
    
    @StateObject var vm = ArticlesViewModel()
    
    @State private var searchText: String = ""
    
    var trimmedSearchText: String { searchText.trimmingCharacters(in: .whitespacesAndNewlines)}
    
    var body: some View {
        NavigationView {
            ArticlesListView()
                .environmentObject(vm)
                .overlay {
                    if case .initial = vm.loadingState, vm.articles.isEmpty {
                        ProgressView()
                    }
                }
                .navigationTitle("News")
                .searchable(text: $searchText)
                .onChange(of: trimmedSearchText) { newValue in
                    vm.searchArticle(searchText: newValue)
                }
                .refreshable {
                    vm.refreshArticles()
                }
                .onAppear {
                    vm.getArticles()
                }
        }
    }
}

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView()
    }
}

