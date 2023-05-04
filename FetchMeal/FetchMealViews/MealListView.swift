//
//  MealListView.swift
//  FetchMeal
//
//  Created by Roman on 5/3/23.
//

import SwiftUI

struct MealListView: View {
//    @Environment(\.dismissSearch)
//    private var dismissSearch
    @ObservedObject var mealFetcher: MealFetcher
    @State private var error: MealFetcher.UserError? = nil
    @State private var hasError = false
    @State private var searchText = ""
    @State private var details: String = ""
    
    
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                if mealFetcher.isMealsRefreshing{
                    LoadingView()
                }else{
                    List {
                        ForEach(mealFetcher.filteredMeals(searchText: searchText), id: \.id) { item  in
                            
                            
                            
                            NavigationLink{
                                MealDatailView(details: details)
                                    .task {
                                       let result = await getDetails(id: item.id)
                                       details = result
                                    }
                            }label:{
                                MealRowView(meal: item)
                                    
                            }
                            
                            
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Meals")
                    .searchable(text: $searchText)
                
                }
 
            }
            .task {
                await getAllMeals()
            }
            .alert(isPresented: $hasError, error: error){
                Button{
                    Task{
                        await getAllMeals()
                    }
                }label: {
                    Text("Retry")
                }
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


private extension MealListView {
    
    func getDetails(id: String)  async -> String {
        do{
            return try await mealFetcher.getDetails(id: id)
        } catch {
            if let userError = error as? MealFetcher.UserError {
                self.hasError = true
                self.error = userError
            }
            return "Failed to provide Description"
        }
    }
    
    
    
    
    func getAllMeals() async {
        do{
            try await mealFetcher.fetchAllMeals()
        } catch {
            if let userError = error as? MealFetcher.UserError {
                self.hasError = true
                self.error = userError
            }
        }
    }
}
