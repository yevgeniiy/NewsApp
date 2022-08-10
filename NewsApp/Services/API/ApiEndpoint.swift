//
//  ApiEndpoint.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 09.08.2022.
//

import Foundation

enum ApiEndpoint {
    case getTopHeadlines(page:String)
    case getSources
    case searchArticle(searchString: String, page:String)
    case getArticlesFromSource(source: String, page:String)
    case searchArticleFromSource(searchString: String, source: String, page:String)
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
    
    var parameters: [String: String] {
        var dict = ["apiKey": APIConstants.apiKey, "language": UserSettings.newsLanguage.code, "pageSize": APIConstants.pageSize]
        switch self {
        case .getTopHeadlines(let page):
            dict["page"] = page
        case .searchArticle(let searchString, let page):
            dict["q"] = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            dict["page"] = page
        case .getArticlesFromSource(let source, let page):
            dict["sources"] = source
            dict["page"] = page
        case .searchArticleFromSource(let searchString, let source, let page):
            dict["sources"] = source
            dict["q"] = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            dict["page"] = page
        default: return dict
        }
        return dict
    }
}
