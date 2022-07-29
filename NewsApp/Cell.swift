//
//  Cell.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 29.07.2022.
//

import SwiftUI

struct NewsCell: View {
    
    let article: Articles
    
    var body: some View {
        
    }
    
    private var asyncImage: some View  {
        AsyncImage(url: article.imageURL) { phase in
            switch phase {
            case .empty:
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            case .failure:
                HStack {
                    Spacer()
                    Image(systemName: "photo")
                        .imageScale(.large)
                    Spacer()
                }
                
                
            @unknown default:
                fatalError()
            }
        }
        #if os(iOS)
        .asyncImageFrame(horizontalSizeClass: horizontalSizeClass ?? .compact)
        #elseif os(macOS)
        .frame(height: 180)
        #elseif os(watchOS)
        .frame(maxWidth: 40, maxHeight: 70)
        #endif
        .background(Color.gray.opacity(0.6))
        #if os(watchOS)
        .cornerRadius(4)
        #endif
        .clipped()
    }
    
}
