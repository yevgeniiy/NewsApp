//
//  SourceResponse.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 09.08.2022.
//

import Foundation

struct SourceResponse: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String?
    let url: String
    let category: String
    let language: String
    let country: String
}
