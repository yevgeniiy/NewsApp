//
//  ApiEndpoint.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 09.08.2022.
//

import Foundation

enum ApiEndpoint {
    case getTopHeadlines
    case getSources
    case searchArticle(searchString: String)
    case getArticlesFromSource(source: String)
}

extension ApiEndpoint {
    
    var path: String {
        switch self {
        case .getTopHeadlines:
            return "top-headlines"
        case .getSources:
            return "top-headlines/sources"
        case .searchArticle, .getArticlesFromSource:
            return "everything"
        }
    }
    
    var parameters: [String: String] {
        var dict = ["apiKey": APIConstants.apiKey, "language": UserSettings.newsLanguage.code]
        switch self {
        case .getTopHeadlines:
            return dict
        case .getSources:
            return dict
        case .searchArticle(let searchString):
            dict["q"] = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        case .getArticlesFromSource(let source):
            dict["sources"] = source
        }
        
        return dict
    }
}
