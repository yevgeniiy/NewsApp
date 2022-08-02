//
//  EmptyNewsView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 01.08.2022.
//

import SwiftUI

struct EmptyNewsView: View {
    var body: some View {
        VStack {
            Image(systemName: "newspaper")
                .resizable()
                .frame(width: 100, height: 100)
            Text("No news to show")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
        }
        .foregroundColor(.gray.opacity(0.8))
    }
}

struct EmptyNewsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyNewsView()
    }
}
