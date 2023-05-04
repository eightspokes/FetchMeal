//
//  LoadingView.swift
//  FetchMeal
//
//  Created by Roman on 5/4/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack{
            Text ("🧑🏻‍🍳")
                .font(.system(size: 80))
            ProgressView("Getting desserts...")    .scaleEffect(1.5)
                .font(.system(size:15))
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
