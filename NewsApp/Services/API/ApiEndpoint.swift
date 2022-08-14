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
    case searchArticleFromSource(searchString: String, source: String)
}

extension ApiEndpoint {
    
    var path: String {
        switch self {
        case .getTopHeadlines:
            return "top-headlines"
        case .getSources:
            return "top-headlines/sources"
        case .searchArticle, .getArticlesFromSource, .searchArticleFromSource:
            return "everything"
        }
    }
    
    var defaults: [String: String] {
        return ["apiKey": APIConstants.apiKey,
                "language": UserSettings.newsLanguage.code]
    }
    
    var parameters: [String: String] {
        switch self {
        case .searchArticle(let searchString):
            return ["q": searchString]
        case .getArticlesFromSource(let source):
            return ["sources": source]
        case .searchArticleFromSource(let searchString, let source):
            return ["sources": source,
                    "q": searchString]
        default: return [:]
        }
    }
}
