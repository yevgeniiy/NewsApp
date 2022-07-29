//
//  ContentView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 28.07.2022.
//

import SwiftUI
import WebKit

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
                .onAppear(perform: vm.fetchAllArticles)
            .navigationTitle("News")
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                vm.searchArticles(from: searchText)
            }
            .refreshable {
                vm.fetchAllArticles()
            }
            .alert(vm.error ?? "Unknown error", isPresented: $vm.hasError) {
                Button("Ok", role: .cancel) {}
                }
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
