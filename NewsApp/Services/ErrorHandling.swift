//
//  ErrorHandling.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 06.08.2022.
//

import Foundation

@MainActor
class ErrorHandling: ObservableObject {
    @Published var currentAlert: Error?
    @Published var hasError: Bool = false
    
    static var shared = ErrorHandling()

    func handle(error: Error) {
        hasError = true
        currentAlert = error
    }
}
