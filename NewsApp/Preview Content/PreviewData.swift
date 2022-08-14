//
//  PreviewData.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 02.08.2022.
//

import Foundation

class PreviewData {
    
    static func loadJson(fileName: String) -> [ArticlesResponse] {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NewsApiResponse.self, from: data)
                return jsonData.articles!
            } catch {
                print("error:\(error)")
                return []
            }
        }
        return []
    }
}
