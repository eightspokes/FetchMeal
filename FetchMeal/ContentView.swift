//
//  ContentView.swift
//  FetchMeal
//
//  Created by Roman on 5/3/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var mealFetcher = MealFetcher()
    
    var body: some View {
        MealListView(mealFetcher: mealFetcher)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
