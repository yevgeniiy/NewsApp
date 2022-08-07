//
//  NewsLanguages.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 03.08.2022.
//

import Foundation

enum NewsLanguage: String, CaseIterable, Identifiable {
    case arabic, german, english, spanish, french, hebrew, italian, dutch, norwegian, portuguese, russian, swedish, chinese
    
    var id:String { self.rawValue }
    
    var code: String {
        switch self {
        case .arabic: return "ar"
        case .german: return "de"
        case .english: return "en"
        case .spanish: return "es"
        case .french: return "fr"
        case .hebrew: return "he"
        case .italian: return "it"
        case .dutch: return "nl"
        case .norwegian: return "no"
        case .portuguese: return "pt"
        case .russian: return "ru"
        case .swedish: return "sv"
        case .chinese: return "zh"
        }
    }
    
    var description: String {
        switch self {
        case .arabic:
            return "Arabic"
        case .german:
            return "German"
        case .english:
            return "English"
        case .spanish:
            return "Spanish"
        case .french:
            return "French"
        case .hebrew:
            return "Hebrew"
        case .italian:
            return "Italian"
        case .dutch:
            return "Dutch"
        case .norwegian:
            return "Norwegin"
        case .portuguese:
            return "Portuguese"
        case .russian:
            return "Russian"
        case .swedish:
            return "Swedish"
        case .chinese:
            return "Chinese"
        }
    }
}
