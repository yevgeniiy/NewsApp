//
//  FavouritiesView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 04.08.2022.
//

import SwiftUI

struct FavoritesView: View {

    @EnvironmentObject var errorHandling: ErrorHandling

    @State private var searchText: String = ""
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ArticlesDB.additionDate, ascending: true)]) private var articles: FetchedResults<ArticlesDB>
    
    var body: some View {
        NavigationView {
            FavoritesListView(articles: articles)
                .overlay {
                    if articles.isEmpty {
                        EmptyNewsView()
                    }
                }
                .navigationTitle("Favorites")
                .searchable(text: $searchText)
        }
        .onChange(of: searchText) { searchString in
            articles.nsPredicate = searchString.isEmpty ? nil : NSPredicate(format: "articleTitle contains[cd] %@", searchString)
        }
    }
}

struct FavoritesListView: View {
    
    var articles: FetchedResults<ArticlesDB>
    
    var body: some View {
        List {
            ForEach(self.articles.reversed(), id: \.self) { article in
                FavoritesRowView(article: article)
            }
        }
        .listStyle(.inset)
    }
}


struct FavouritiesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
