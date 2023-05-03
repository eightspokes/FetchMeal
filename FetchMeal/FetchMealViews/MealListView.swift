//
//  MealListView.swift
//  FetchMeal
//
//  Created by Roman on 5/3/23.
//

import SwiftUI

struct MealListView: View {
    @ObservedObject var mealFetcher: MealFetcher
    @State private var error: MealFetcher.UserError? = nil
    @State private var hasError = false
    
    
    
    var body: some View {
        
        NavigationView{
            ZStack{
                if mealFetcher.isRefreshing{
                    ProgressView()
                }else{
                    List(mealFetcher.meals, id: \.id){ item in
                        Text(item.strMeal)
                            .listRowSeparator(Visibility.hidden)
                        
                    }
                    .listStyle(.plain)
                    .navigationTitle("Meals")
                    
                }
 
            }
            .task {
                await execute()
            }
            .alert(isPresented: $hasError, error: error){
                Button{
                    Task{
                        await execute()
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
    func execute() async {
        do{
            try await mealFetcher.fetchAllBreeds()
        } catch {
            if let userError = error as? MealFetcher.UserError {
                self.hasError = true
                self.error = userError
            }
        }
    }
}
