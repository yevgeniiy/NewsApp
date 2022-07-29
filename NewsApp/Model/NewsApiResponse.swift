//
//  NewsApiResponse.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 28.07.2022.
//

import Foundation

import Foundation

struct NewsApiResponse: Decodable {
    
    let status: String
    let articles: [Articles]?
    
}
