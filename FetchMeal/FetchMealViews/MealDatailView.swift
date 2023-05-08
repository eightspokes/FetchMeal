//
//  MealDatailView.swift
//  FetchMeal
//
//  Created by Roman on 5/4/23.
//
import SwiftUI


struct MealDatailView: View {
    
    var mealFetcher: MealFetcher
    let id: String
    @State var meal: Meal?
    var body: some View {
        if mealFetcher.isLoading{
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
                    VStack(alignment: .leading, spacing:-10){
                        Text("Ingredients")
                            .font(.title3).bold()
                            
                            .padding(.bottom)
                        createTableView(ingredientsAndMeasures: meal?.getIngrediatnsAndMeasures() ?? ["":""] )
                            
                        Spacer()
                    }
                    .padding(.leading,10)
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
                await self.meal = mealFetcher.fetchMeals(id: self.id)
            }
            .padding()
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
                    .font(.caption.bold())
            }
        }   
    }
}


