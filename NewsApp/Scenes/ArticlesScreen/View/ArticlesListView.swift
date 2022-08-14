//
//  ArticlesListView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 14.08.2022.
//

import SwiftUI

struct ArticlesListView: View {
    
    @EnvironmentObject var vm: ArticlesViewModel
    
    var body: some View {
        List {
            ForEach(vm.articles, id: \.id) { article in
                ArticlesRowView(article: article)
                    .onAppear {
                        if article == vm.articles.last {
                            Task { await vm.loadMore() }
                        }
                    }
            }
            if case .success = vm.loadingState, vm.articles.isEmpty {
                ArticlesEmptyView()
            }
        }
    }
}


struct ArticlesListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesListView()
    }
}
