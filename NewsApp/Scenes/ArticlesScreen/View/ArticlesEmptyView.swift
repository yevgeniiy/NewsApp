//
//  EmptyNewsView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 01.08.2022.
//

import SwiftUI

struct ArticlesEmptyView: View {
    var body: some View {
        VStack {
            Image(systemName: "newspaper")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 50, height: 50)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            Text("No news to display. Try changing your search filters or refresh the page.")
                .multilineTextAlignment(.center)
                .lineLimit(4)
                .padding(.horizontal, 20.0)
                .foregroundColor(.gray)
                .font(.subheadline)
        }
    }
}

struct ArticlesEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesEmptyView()
    }
}
