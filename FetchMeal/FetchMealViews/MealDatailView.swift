//
//  MealDatailView.swift
//  FetchMeal
//
//  Created by Roman on 5/4/23.
//
import SwiftUI
/**
  View that displays detailed information about a meal.
*/
struct MealDatailView: View {
    @EnvironmentObject var favorites: Favorites
    @State var meal: Meal?
    var mealFetcher: MealFetcher
    let id: String
    
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
                            .font(.title3).fontWeight(.light)
                            .padding(.bottom)
                            .padding(.top, -5)
                        
                        createTableView(ingredientsAndMeasures: meal?.getIngrediatnsAndMeasures() ?? [("","")])
                        Spacer()
                    }
                    .padding(.leading,10)
                    Spacer()
                }
                Text(meal?.strMeal ?? "Meal name not available")
                    .font(.title.weight(.light ))
                    .padding(.vertical)
                Divider()
                ScrollView() {
                    Text(meal?.strInstructions ?? "Instructions not available")
                        .font(.callout)
                        .fontWeight(.light)
                    if let meal{
                        Button(favorites.contains(meal) ? "Remove from Favorites" : "Add to Favorites"){
                            if favorites.contains(meal){
                                favorites.remove(meal)
                            }else{
                                favorites.add(meal)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.horizontal)
                    }
                }
            }.task {
                await self.meal = mealFetcher.fetchMeals(id: self.id)
            }
            .padding()
            .background(DrawingConstants.backgroundColor)
        }
    }
    /**
     Creates a SwiftUI view for displaying a table of ingredient names and their corresponding measurements.
        – Parameter : array of tuples of ingredients and measures
     */
    func createTableView(ingredientsAndMeasures: [(String, String)]) -> some View {
        let rows = ingredientsAndMeasures.map { key, value in TableRow(name: key, value: value) }
        return Table(rows: rows) { row in
            HStack {
                Text(row.name)
                Text(row.value)
            }
        }
    }
}
/**
 View that displays an image of a meal. It uses an AsyncImage to load and display the image asynchronously from a URL provided as mealImage string parameter.
 */
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
/**
    Represents a single row in a table view. It conforms to the Identifiable protocol, which means that it has a unique identifier property called id. The id property is initialized to a new UUID value by default.
 */
struct TableRow: Identifiable {
    var id = UUID()
    let name: String
    let value: String
}
/**
    View that constructs and displays generic conten based on TableRow object provided
 */
struct Table<Content: View>: View {
    let rows: [TableRow]
    let content: (TableRow) -> Content
    
    var body: some View {
        VStack(alignment: .leading){
            ForEach(rows) { row in
                content(row)
                    .font(.caption.weight(.light))
            }
        }   
    }
}


