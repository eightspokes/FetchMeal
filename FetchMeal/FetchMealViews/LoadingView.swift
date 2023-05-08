//
//  LoadingView.swift
//  FetchMeal
//
//  Created by Roman on 5/4/23.
//

import SwiftUI
/**
 View that displays a loading screen while the app is fetching data.
*/
struct LoadingView: View {
    var body: some View {
        ZStack{
            DrawingConstants.backgroundColor
                .ignoresSafeArea()
            VStack{
                Text ("🧑🏻‍🍳")
                    .font(.system(size: 80))
                ProgressView("Getting desserts...")
                    .scaleEffect(1.5)
                    .font(.system(size:15))
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
