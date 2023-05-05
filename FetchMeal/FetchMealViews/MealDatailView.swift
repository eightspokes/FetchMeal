//
//  MealDatailView.swift
//  FetchMeal
//
//  Created by Roman on 5/4/23.
//

import SwiftUI


struct MealImage: View{
    
    var mealImage: String
    var body: some View{
        AsyncImage(url: URL(string: mealImage)) { phase in
            if let image = phase.image {
                image.resizable() 
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(5)
            } else if phase.error != nil {
                Color.gray
            } else {
                ProgressView()
            }
        }
    }
}

struct MealDatailView: View {
    
    let mealFetcher: MealFetcher
    let id: String
    @State var meal: Meal?
    var body: some View {
        if mealFetcher.isMealsRefreshing{
            LoadingView()
        }else{
            VStack(){
                HStack{
                    VStack{
                        if let mealImage = meal?.strMealThumb {
                            MealImage(mealImage: mealImage)
                        }
                        Spacer()
                    }
                    Spacer()
                    VStack(spacing:-10){
                        Text("Ingredients")
                            .font(.title3).italic().bold()
                            .padding(.bottom)
                        createTableView(ingredientsAndMeasures: meal?.getIngrediatnsAndMeasures() ?? ["":""] )
                            .padding(.leading, 10)
                        Spacer()
                    }
                    Spacer()
                }
                Text(meal?.strMeal ?? "Meal name not available")
                    .font(.title.bold())
                    .padding(.vertical)
                Divider()
                ScrollView() {
                    Text(meal?.strInstructions ?? "Instructions not available")
                }
                Spacer()
                    
            }.task {
                await getMealWithDetails(id: self.id)
            }.padding()
        }
    }
    
    func createTableView(ingredientsAndMeasures: [String: String]) -> some View {
        let rows = ingredientsAndMeasures.map { key, value in TableRow(name: key, value: value) }
        return Table(rows: rows) { row in
            HStack {
                Text(row.name)
                Text(row.value)
            }
        }
    }
}

struct TableRow: Identifiable {
    var id = UUID()
    let name: String
    let value: String
}

struct Table<Content: View>: View {
    let rows: [TableRow]
    let content: (TableRow) -> Content
    
    var body: some View {
        VStack(alignment: .leading){
            ForEach(rows) { row in
                content(row)
                    .font(.footnote).italic()
            }
        }
        
        
    }
}

private extension MealDatailView {
    
    func getMealWithDetails(id: String) async   {
        do{
            try await self.meal = mealFetcher.getMealWithDetails(id: id)
            print(self.meal?.getIngrediatnsAndMeasures())
        } catch {
            if let userError = error as? MealFetcher.UserError {
                // self.hasError = true
                // self.error = userError
            }
            
        }
    }
}
