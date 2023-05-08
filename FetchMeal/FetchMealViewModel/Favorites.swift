//
//  Favorites.swift
//  FetchMeal
//
//  Created by Roman on 5/8/23.
//

import Foundation
/**
 A class that manages a set of meal IDs that the user has favorited.
 The class provides methods to add and remove meals from the favorites list, and to check if a meal is already favorited.
 The `Favorites` class conforms to the `ObservableObject` protocol, which allows SwiftUI views to automatically update themselves when the `mealsIds` property changes.
 */
class Favorites: ObservableObject{
    private var mealsIds: Set<String>
    private let saveKey = "Favorites"
    
    init(){
        if let savedMealsIds = UserDefaults.standard.array(forKey: saveKey) as? [String] {
            mealsIds = Set(savedMealsIds)
        } else {
            mealsIds = []
        }
    }
    /**
     Checks if a given meal is in the favorites list.
     - Parameter meal: The meal to be checked.
     - Returns: `true` if the meal is in the favorites list, otherwise `false`.
     */
    func contains(_ meal: Meal) -> Bool{
        for mealId in mealsIds{
            if meal.id == mealId{
                return true
            }
        }
        return false
    }
    /**
     Adds a meal to the favorites list.
     - Parameter meal: The meal to be added.
     */
    func add(_ meal: Meal){
        objectWillChange.send()
        mealsIds.insert(meal.id)
        save()
    }
    /**
     Removes a meal from the favorites list.
     - Parameter meal: The meal to be removed.
     */
    func remove( _ meal: Meal){
        objectWillChange.send()
        mealsIds.remove(meal.id)
        save()
        
    }
    /**
     Saves the favorites list to user defaults.
     */
    func save(){
        UserDefaults.standard.set(Array(mealsIds), forKey: saveKey)
    }
}
