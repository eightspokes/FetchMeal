//
//  ContentView.swift
//  FetchMeal
//
//  Created by Roman on 5/3/23.
//

import SwiftUI
/**
    Entry point of the app. Provides MealListView with  MealFetcher and Favorites instances
*/
struct ContentView: View {
    @StateObject var mealFetcher = MealFetcher()
    @StateObject var favorites = Favorites()
    var body: some View {
        MealListView(mealFetcher: mealFetcher)
            .environmentObject(favorites)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
