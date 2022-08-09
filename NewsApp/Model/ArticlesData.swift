//
//  Article.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 28.07.2022.
//

import Foundation
import SwiftUI

struct ArticlesData: Decodable, Identifiable {
    
    let id = UUID()
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    
    func addToFavorite() async throws {
        let viewContext = PersistenceController.shared.container.viewContext
        let entity = ArticlesDB(context: viewContext)
        entity.articleTitle = self.title
        entity.articleDescription = self.description
        entity.urlToImage = self.urlToImage
        entity.url = self.url
        entity.additionDate = Date()
        
        if let urlString = self.urlToImage {
            let url = URL(string: urlString)!
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if response is HTTPURLResponse {
                entity.savedImage = data
            }
        }
        try viewContext.save()
    }
    
}
