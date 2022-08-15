//
//  NewsRowView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 29.07.2022.
//

import SwiftUI

struct ArticlesRowView: View {
    
    let article: ArticlesResponse
    
    @State private var showWebView: Bool = false
    
    var body: some View {
        Button {
            self.showWebView = true
        } label: {
            HStack {
                asyncImage
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
                    .clipped()
                VStack {
                    Text(article.title)
                        .font(.headline)
                        .lineLimit(1)
                        .padding(.bottom, 1)
                        .foregroundColor(.black)
                    Text(article.description ?? "")
                        .lineLimit(2)
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
            }
            .frame(height: 70)
        }
        .padding(5)
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                Task {
                    do {
                        try await article.addToFavorite()
                    } catch {
                        ErrorHandling.shared.handle(error: error)
                    }
                }
            } label: {
                Label("Favorite", systemImage: "heart")
            }.tint(.green)
        }
        .sheet(isPresented: $showWebView) {
            WebView(url: URL(string: article.url)!)
        }
    }
}



struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesRowView(article: ArticlesResponse(title: "Tory leadership latest: Sunak says yes to return of grammar schools - BBC", description: "But his team later clarifies Mr Sunak was only backing the expansion of existing grammar schools.", url: "https://www.bbc.co.uk/news/uk-62340247", urlToImage: "n"))
    }
}

extension ArticlesRowView {
    
    private var asyncImage: some View  {
        Group {
            if let url = article.urlToImage, !url.isEmpty {
                AsyncImage(url: URL(string: url)) { phase in
                    if let image = phase.image {
                        image.resizable()
                    } else if phase.error != nil {
                        noImageAvailable
                    } else {
                        ProgressView()
                    }
                }
            } else {
                noImageAvailable
            }
        }
    }
    
    private var noImageAvailable: some View {
        Image(systemName: "photo")
            .resizable()
            .foregroundColor(.gray)
            .padding()
            .background(Color.gray.opacity(0.2))
    }
}
