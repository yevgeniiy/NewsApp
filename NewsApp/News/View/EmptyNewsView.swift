//
//  EmptyNewsView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 01.08.2022.
//

import SwiftUI

struct EmptyNewsView: View {
    var body: some View {
        Text("No news to show")
            .font(.headline)
    }
}

struct EmptyNewsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyNewsView()
    }
}
