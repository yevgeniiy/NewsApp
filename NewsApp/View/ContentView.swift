//
//  ContentView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 28.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var vm = ViewModel()
    
    @State private var searchText: String = ""
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(vm.articles, id: \.id) { article in
                    CellView(article: article)
                }
            }
            .listStyle(.inset)
            .navigationTitle("News")
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                Task { await vm.searchArticles(from: searchText) }
            }
            .refreshable {
                Task { await vm.fetchAllArticles() }
            }
            .task {
                await vm.fetchAllArticles()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
