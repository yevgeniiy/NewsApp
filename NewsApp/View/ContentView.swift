//
//  ContentView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 28.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var errorHandling = ErrorHandling.shared
    
    var body: some View {
            TabView {
                ArticlesView()
                    .tabItem {
                        Label("News", systemImage: "newspaper")
                    }
                SourcesView()
                    .tabItem {
                        Label("Sources", systemImage: "book.closed")
                    }
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart")
                    }
                UserSettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
            .alert(errorHandling.localizedError, isPresented: $errorHandling.hasError) {
                Button("Ok") {
                    errorHandling.dismissButton()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
