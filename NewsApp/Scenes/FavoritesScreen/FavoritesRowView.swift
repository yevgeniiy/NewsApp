//
//  FavoritesRowView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 04.08.2022.
//

import SwiftUI

struct FavoritesRowView: View {
    
    let article: ArticlesDB
    
    @State private var showWebView: Bool = false
    
    @EnvironmentObject var errorHandling: ErrorHandling
    
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
                    Text(article.articleTitle ?? "")
                        .font(.headline)
                        .lineLimit(1)
                        .padding(.bottom, 1)
                    Text(article.articleDescription ?? "")
                        .lineLimit(2)
                        .font(.subheadline)
                }
                
            }
            .frame(height: 70)
        }
        .padding(5)
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                withAnimation {
                    do {
                        try article.delete()
                    } catch {
                        errorHandling.handle(error: error)
                    }
                    
                }
            } label: {
                Label("Delete", systemImage: "trash")
            }.tint(.red)
        }
        .sheet(isPresented: $showWebView) {
            WebView(url: URL(string: article.url ?? "")!)
        }
    }
}

struct FavoritesRowView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let article = ArticlesDB(context: context)
        article.articleTitle = "Senate backs Finland"
        article.articleDescription = "Global health officials are flagging a troubling trend among children as routine vaccination rates are the lowest they’ve been in 30 years, according to a ne..."
        article.url = "https://www.youtube.com/watch?v=9PmrVvT8-Iw"
        article.urlToImage = "https://i.ytimg.com/vi/9PmrVvT8-Iw/hqdefault.jpg"
        
        return FavoritesRowView(article: article).environment(\.managedObjectContext, context)
    }
}

extension FavoritesRowView {
    
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
