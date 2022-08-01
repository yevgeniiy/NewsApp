//
//  SwiftUIView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 29.07.2022.
//

import SwiftUI

struct CellView: View {
    
    let article: Articles
    
    var body: some View {
        NavigationLink(destination: WebView(url: URL(string: article.url)!)) {
            HStack {
                asyncImage
                    .frame(maxWidth: 100, maxHeight: 100)
                    .cornerRadius(10)
                VStack {
                    Text(article.title)
                        .font(.headline)
                        .lineLimit(1)
                    Text(article.description!)
                        .lineLimit(2)
                        .font(.body)
                }
                
            }
            .padding()
            .frame( height: 100)
        }
        
    }
    
    private var asyncImage: some View  {
        Group {
            if let url = article.urlToImage, !url.isEmpty {
                AsyncImage(url: URL(string: url)) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
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
        Image("noimage")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(article: Articles(title: "Tory leadership latest: Sunak says yes to return of grammar schools - BBC", description: "But his team later clarifies Mr Sunak was only backing the expansion of existing grammar schools.", url: "https://www.bbc.co.uk/news/uk-62340247", urlToImage: "n"))
    }
}
