//
//  UserPreferencesView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 03.08.2022.
//

import SwiftUI

struct UserSettingsView: View {
    
    @State private var selectedNewsLanguage: NewsLanguage = UserSettings.newsLanguage
    
    var body: some View {
        NavigationView {
            List {
                Picker("News language", selection: $selectedNewsLanguage) {
                    ForEach(NewsLanguage.allCases) { value in
                        Text(value.description).tag(value)
                    }
                }
            }
            .navigationBarTitle("Settings")
            .onChange(of: selectedNewsLanguage) { newValue in
                UserSettings.newsLanguage = newValue
            }
        }
    }
}

struct UserPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingsView()
    }
}
