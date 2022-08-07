//
//  UserSettings.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 03.08.2022.
//

import Foundation

final class UserSettings {
    
    private enum SettingsKeys: String {
        case newsLanguage
    }
    
    static var newsLanguage: NewsLanguage {
        get {
            let defaults = UserDefaults.standard
            if let rawValue = defaults.string(forKey: SettingsKeys.newsLanguage.rawValue) {
                return NewsLanguage(rawValue: rawValue)!
            } else {
                return NewsLanguage.english
            }
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.newsLanguage.rawValue
            
            if !newValue.rawValue.isEmpty {
                defaults.set(newValue.rawValue, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
