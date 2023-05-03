//
//  Meal.swift
//  FetchMeal
//
//  Created by Roman on 5/3/23.
//

struct Meal: Codable, Identifiable{
    var id: String {idMeal}
    let strMeal: String
    //let strMealThumb: String
    let idMeal: String
}


struct Meals: Codable {
    let meals: [Meal]
}
