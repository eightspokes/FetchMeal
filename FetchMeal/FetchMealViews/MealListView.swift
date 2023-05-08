//
//  MealListView.swift
//  FetchMeal
//
//  Created by Roman on 5/3/23.
//

import SwiftUI
/**
    Stores constant values
 */
struct DrawingConstants{
    static let backgroundColor = Color(red: 255/255, green: 234/255, blue: 236/255)
}
/**
    Displays a list of meals retrieved from a MealFetcher object. The view includes a search bar and an error alert with a retry button.
    
    The view is  decorated with a background color defined in the DrawingConstants struct. It also displays user's favorite meals.
 
 */
struct MealListView: View {
    
    @EnvironmentObject var favorites: Favorites
    @ObservedObject var mealFetcher: MealFetcher
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack{
            ZStack{
                if mealFetcher.isLoading{
                    LoadingView()
                }else{
                    List {
                        ForEach(mealFetcher.filteredMeals(searchText: searchText), id: \.id) { item  in
                            NavigationLink{
                                MealDatailView(meal: item, mealFetcher: mealFetcher, id: item.id)
                            }label:{
                                MealRowView(meal: item)
                            }
                            .listRowBackground(DrawingConstants.backgroundColor)
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Desserts")
                    .searchable(text: $searchText)
                }
            }.background(DrawingConstants.backgroundColor)
        }
        .task {
            await _ = mealFetcher.fetchMeals()
        }
        .alert(mealFetcher.errorMessage, isPresented: $mealFetcher.hasError){
            Button{
                Task{
                    await mealFetcher.fetchMeals()
                }
            }label: {
                Text("Retry")
            }
        }
    }
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        let mealFetcher = MealFetcher()
        MealListView(mealFetcher: mealFetcher)
            .environmentObject(Favorites())
    }
}


