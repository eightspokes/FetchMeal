//
//  MealRowView.swift
//  FetchMeal
//
//  Created by Roman on 5/4/23.
//

import SwiftUI

struct MealRowView: View {
    let meal: Meal
    let imageSize: CGFloat = 100
    var body: some View {
        HStack(spacing: 5){
            if  let meal = meal.strMealThumb {
                AsyncImage(url: URL(string: meal)) { phase in
                    if let image = phase.image {
                        image.resizable() // Displays the loaded i
                            .scaledToFit()
                            .frame(width: imageSize, height: imageSize)
                            .clipped()
                            .cornerRadius(5)
                        
                    } else if phase.error != nil {
                        Color.gray.frame(width: imageSize, height: imageSize)
                    } else {
                        ProgressView()
                            .frame(width: imageSize, height: imageSize)
                    }
                }
            }
            
            Text(meal.strMeal)
                .font(.title2)
            
        }
    }
}

struct MealRowView_Previews: PreviewProvider {
    static var previews: some View {
        let meal = Meal.example()
        MealRowView(meal: meal)
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
