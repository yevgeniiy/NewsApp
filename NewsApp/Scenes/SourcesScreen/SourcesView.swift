//
//  SourcesView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 09.08.2022.
//

import SwiftUI

struct SourcesView: View {
    
    @State private var sources: [SourceResponse] = []
    
    @EnvironmentObject private var errorHandling: ErrorHandling
    
    @State private var _searchText: String = ""
    @State private var isLoading: Bool = true
    
    private var searchText: String {
        get { return self._searchText.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
    
    private var searchResults: [SourceResponse] {
        if searchText.isEmpty {
            return sources
        } else {
            return sources.filter { $0.name.localizedStandardContains(searchText)}
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                if !sources.isEmpty {
                    ForEach(searchResults) { source in
                        NavigationLink(source.name) {
                            ArticlesSourceView(source: source)
                        }
                    }
                }
            }
            .navigationTitle("Sources")
            .searchable(text: $_searchText)
        }
        .onAppear {
            updateView()
        }
        .refreshable {
            updateView()
        }
    }
}

struct SourcesView_Previews: PreviewProvider {
    static var previews: some View {
        SourcesView()
    }
}

extension SourcesView {
    
    func updateView() {
        self.isLoading = true
        Task {
            do {
                try await self.sources = NewsAPI.shared.getData(from: .getSources).sources ?? []
                self.isLoading = false
            } catch {
                errorHandling.handle(error: error)
            }
        }
    }
}
