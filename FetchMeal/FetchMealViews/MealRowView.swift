//
//  MealRowView.swift
//  FetchMeal
//
//  Created by Roman on 5/4/23.
//

import SwiftUI
/**
    Displays a single meal row in a list. It shows the meal name, an image, and a heart icon if the meal is a favorite. It uses the `AsyncImage` view for displaying images asynchronously.

  `MealRowView` requires a `Meal` object to be initialized.
  - parameter meal: The `Meal` object to be displayed in the row.
  - parameter imageSize: The size of the image to be displayed. Default value is 100.
  - parameter favorites: An `EnvironmentObject` of `Favorites` used to check if the meal is a favorite.
 */
struct MealRowView: View {
    let meal: Meal
    let imageSize: CGFloat = 100
    let cornerRadius: CGFloat = 5
    @EnvironmentObject var favorites: Favorites
    var body: some View {
        HStack(spacing: 5){
            if  let meal = meal.strMealThumb {
                AsyncImage(url: URL(string: meal)) { phase in
                    if let image = phase.image {
                        image.resizable() // Displays the loaded image
                            .scaledToFit()
                            .frame(width: imageSize, height: imageSize)
                            .clipped()
                            .cornerRadius(cornerRadius)
                    } else if phase.error != nil {
                        Color.gray.frame(width: imageSize, height: imageSize)
                    } else {
                        ProgressView()
                            .frame(width: imageSize, height: imageSize)
                    }
                }
            }
            Text(meal.strMeal)
                .font(.title2.weight(.light))
            Spacer()
            if favorites.contains(meal){
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
    }
}

struct MealRowView_Previews: PreviewProvider {
    static var previews: some View {
        let meal = Meal.example()
        MealRowView(meal: meal)
            .previewLayout(.fixed(width: 400, height: 200))
            .environmentObject(Favorites())
    }
}
