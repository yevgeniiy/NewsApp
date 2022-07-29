//
//  Article.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 28.07.2022.
//

import Foundation

struct Articles: Decodable, Identifiable {

    let id = UUID()
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    
}


