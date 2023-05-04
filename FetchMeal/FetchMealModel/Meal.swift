//
//  Meal.swift
//  FetchMeal
//
//  Created by Roman on 5/3/23.
//

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
    
    
    func getIngrediatnsAndMeasures(){
        print("Getting ingredients and measures")
        let mirror = Swift.Mirror(reflecting: self)
        for child in mirror.children  {
            print("key: \(String(describing: child.label)), value: \(child.value)")
        }
    }
    
    
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(strMeal)
    }
    
    static func example() -> Meal {
        let image = "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"
        return Meal(strMeal: "Apam balic", idMeal: "53049", strMealThumb: image, strInstructions: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "")
    }   
}

struct Meals: Codable {
    var meals: [Meal]
}


