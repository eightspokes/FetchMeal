//
//  MealListView.swift
//  FetchMeal
//
//  Created by Roman on 5/3/23.
//

import SwiftUI

struct MealListView: View {
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
                                MealDatailView(mealFetcher: mealFetcher, id: item.id)
                            }label:{
                                MealRowView(meal: item)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Desserts")
                    .searchable(text: $searchText)
                }
                
            }
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
    }
}


