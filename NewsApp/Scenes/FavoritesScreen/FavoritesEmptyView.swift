//
//  FavoritesEmptyView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 14.08.2022.
//

import SwiftUI

struct FavoritesEmptyView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "heart.slash.circle.fill")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 50, height: 50)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            }
            (Text("You don't have any favorite news yet. Swipe the news you like to the right and press ")+Text(Image(systemName: "heart")).foregroundColor(.red)+Text(" to add it to favorites"))
                .multilineTextAlignment(.center)
                .lineLimit(4)
                .padding(.horizontal, 20.0)
                .foregroundColor(.gray)
                .font(.subheadline)
        }
    }
}

struct FavoritesEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesEmptyView()
    }
}
