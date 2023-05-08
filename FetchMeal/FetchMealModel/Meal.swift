//
//  Meal.swift
//  FetchMeal
//
//  Created by Roman on 5/3/23.
//
import Foundation
/**
    Represents a single meal, including its name, ID, thumbnail image, instructions, and ingredients and their corresponding measures.
 
    The `Meal` struct conforms to the `Codable`, `Identifiable`, and `Hashable` protocols, which allow it to be encoded and decoded from JSON, identified by its `idMeal` property, and hashed for use in collections.
 
 */
struct Meal: Codable, Identifiable, Hashable{
     
     var id: String {idMeal}
     let strMeal: String
     let idMeal: String
     let strMealThumb: String?
     let strInstructions: String?
     let strIngredient1 : String?
     let strIngredient2 : String?
     let strIngredient3 : String?
     let strIngredient4 : String?
     let strIngredient5 : String?
     let strIngredient6 : String?
     let strIngredient7 : String?
     let strIngredient8 : String?
     let strIngredient9 : String?
     let strIngredient10 : String?
     let strIngredient11 : String?
     let strIngredient12 : String?
     let strIngredient13 : String?
     let strIngredient14 : String?
     let strIngredient15 : String?
     let strIngredient16 : String?
     let strIngredient17 : String?
     let strIngredient18 : String?
     let strIngredient19 : String?
     let strIngredient20 : String?
     let strMeasure1: String?
     let strMeasure2: String?
     let strMeasure3: String?
     let strMeasure4: String?
     let strMeasure5: String?
     let strMeasure6: String?
     let strMeasure7: String?
     let strMeasure8: String?
     let strMeasure9: String?
     let strMeasure10: String?
     let strMeasure11: String?
     let strMeasure12: String?
     let strMeasure13: String?
     let strMeasure14: String?
     let strMeasure15: String?
     let strMeasure16: String?
     let strMeasure17: String?
     let strMeasure18: String?
     let strMeasure19: String?
     let strMeasure20: String?
     
     /**
      Extracts the ingredients and their corresponding measures from the Meal instance.
      
      - Returns: A dictionary of String tuple sorted alphabetically by keys, where the keys are the names of the ingredients and the values are their corresponding measures. If an ingredient or a measure is missing, it is omitted from the dictionary.
        
      */
     func getIngrediatnsAndMeasures() -> [(String, String)]{
         
         var ingredientsAndMeasures: [String: String] = [:]
         let mirror = Swift.Mirror(reflecting: self)
         
         //Loop through properties and find Ingredients
         for child in mirror.children{
             guard let ingredientCandidate =  child.label else { continue }
             if ingredientCandidate.contains("Ingredient"){
                 let splitted = ingredientCandidate.split(separator: "Ingredient")
                 var ingredientNumber: String = ""
                 if splitted.count == 2{
                     ingredientNumber = String(splitted[1])
                 }
                 //Find a Measure with the same number
                 for child2 in mirror.children{
                     guard let measureCandidate =  child2.label else { continue }
                     if measureCandidate.contains("Measure"){
                         let splitted = measureCandidate.split(separator: "Measure")
                         var measureNumber: String = ""
                         if splitted.count == 2{
                             measureNumber = String(splitted[1])
                         }
                         //Add measures and ingredients to dictionalry
                         if ingredientNumber == measureNumber{
                             if let ingredient = child.value as? String, let measure = child2.value as? String {
                                 if (child.value as! String).trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
                                     ingredientsAndMeasures[ingredient] = measure
                                 }
                             }
                         }
                     }
                 }
             }
         }
         
         
         return sortDictionaryToTuples(ingredientsAndMeasures)
     }
     /**
      A function that takes a dictionary with String keys and String values, and returns an array of tuples sorted by the keys of the original dictionary.

      - Parameter dict: A dictionary with String keys and String values to be sorted.

      - Returns: An array of tuples sorted by the keys of the original dictionary. Each tuple contains a key-value pair, where the key is a String and the value is a String.
     */
    func sortDictionaryToTuples(_ dict: [String: String]) -> [(String, String)] {
         let sortedKeys = dict.keys.sorted()
         var tupleArray: [(String, String)] = []
         for key in sortedKeys {
             if let value = dict[key] {
                 tupleArray.append((key, value))
             }
         }
         return tupleArray
     }
     /**
      A hash function that combines the hash value of the id and strMeal properties into a single hash value using the Hasher object.
       - Parameters:
         - hasher: that combines the hashed values
      */
     func hash(into hasher: inout Hasher) {
         hasher.combine(id)
         hasher.combine(strMeal)
     }
     /**
        A function that provides a meal Instance for testing purpuses
        - Returns a dummy instance of Meal
      */
     static func example() -> Meal {
         let image = "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"
         return Meal(strMeal: "Apam balic", idMeal: "53049", strMealThumb: image, strInstructions: "", strIngredient1: "Milk", strIngredient2: "Oil", strIngredient3: "Eggs", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "200ml", strMeasure2: "60ml", strMeasure3: "2", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "")
     }
 }
/**
 The `Meals` struct conforms to the `Codable` allows to decode/encode arrays of `Meal` objects
 */
struct Meals: Codable {
    var meals: [Meal]
}


