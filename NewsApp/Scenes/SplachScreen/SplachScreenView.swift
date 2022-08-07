//
//  SplachScreenView.swift
//  NewsApp
//
//  Created by Yevgenii Kryzhanivskyi on 31.07.2022.
//

import SwiftUI

struct SplachScreenView: View {
    
    @State private var isActive = true
    
    var body: some View {
        if isActive {
            LottieView(fileName: "app_loading", loopMode: .playOnce)
                .onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        isActive = false
                    }
                }
        } else {
            ContentView()
        }
        
    }
}

struct AppLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        SplachScreenView()
    }
}
