//
//  Article.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 28.07.2022.
//

import Foundation

struct ArticlesData: Decodable, Identifiable {

    let id = UUID()
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    
    func addToFavorite() throws {
        let viewContext = PersistenceController.shared.container.viewContext
        let entity = ArticlesDB(context: viewContext)
        entity.articleTitle = self.title
        entity.articleDescription = self.description
        entity.urlToImage = self.urlToImage
        entity.url = self.url
        entity.additionDate = Date()
        try viewContext.save()
    }
    
}


