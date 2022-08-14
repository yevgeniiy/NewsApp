//
//  NewsApiResponse.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 28.07.2022.
//

import Foundation

struct NewsApiResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let articles: [ArticlesResponse]?
    let sources: [SourceResponse]?
    
    let code: String?
    let message: String?
    
    var pages:Int { Int((Double(totalResults ?? 1) / Double(APIConstants.pageSize)).rounded(.up)) }
    
}
