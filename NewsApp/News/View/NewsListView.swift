//
//  NewsListView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 02.08.2022.
//

import SwiftUI

struct NewsListView: View {
    
    var articles: [Articles]
    
    var body: some View {
        List {
            ForEach(articles, id: \.id) { article in
                NewsRowView(article: article)
            }
        }
        .listStyle(.inset)
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(articles: PreviewData.loadJson(fileName: "PreviewNewsAPI"))
    }
}
