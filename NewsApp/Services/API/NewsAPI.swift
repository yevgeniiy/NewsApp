//
//  API.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 29.07.2022.
//

import Foundation

final class NewsAPI {
    
    typealias NetworkResponse = (data: Data, response: URLResponse)
    
    static let shared = NewsAPI()
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    private let baseURL = APIConstants.baseURL
    
    func getData(from endpoint: ApiEndpoint, page: Int?) async throws -> NewsApiResponse {
        let request = try createRequest(from: endpoint, page: page)
        let response: NetworkResponse = try await session.data(for: request)
        guard response.response is HTTPURLResponse else {
            throw APIErrors.badResponse
        }
        let decodedData = try decoder.decode(NewsApiResponse.self, from: response.data)
        if decodedData.status == "ok" {
            return decodedData
        } else if decodedData.status == "error" {
            throw NSError(domain: "NewsAPI", code: 1, userInfo: [NSLocalizedDescriptionKey: decodedData.message ?? "Unknown error."])
        } else {
            throw APIErrors.unknownError
        }
    }
    
    private func createRequest(from endpoint: ApiEndpoint, page: Int?) throws -> URLRequest {
        
        guard var urlComponents = URLComponents(string: baseURL.appending(endpoint.path)) else {
            throw APIErrors.invalidPath
        }
        
        var parameters = endpoint.parameters
        parameters.merge(endpoint.defaults) {(current, _) in current }
        
        if page != nil {
            let pageParameters = ["page": String(page!),
                                  "pageSize": String(APIConstants.pageSize)]
            parameters.merge(pageParameters) {(current, _) in current }
        }

        urlComponents.queryItems = parameters.compactMap({param -> URLQueryItem in
            return URLQueryItem(name: param.key, value: param.value) })
        
        guard let url = urlComponents.url else {
            throw APIErrors.badRequest
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

