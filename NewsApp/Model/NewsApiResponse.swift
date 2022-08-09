//
//  NewsApiResponse.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 28.07.2022.
//

import Foundation

struct NewsApiResponse: Decodable {
    
    let status: String
    let articles: [ArticlesData]?
    let sources: [SourceResponse]?
    
    let code: String?
    let message: String?
    
}
