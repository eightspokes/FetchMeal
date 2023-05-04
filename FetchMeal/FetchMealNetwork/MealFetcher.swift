//
//  MealFetcher.swift
//  FetchMeal
//
//  Created by Roman on 5/3/23.
//

import Foundation


class MealFetcher: ObservableObject {
    @Published var meals = [Meal]()
    @Published var mealDetails = [Meal]()
    @Published private(set) var isMealsRefreshing = false
    @Published private(set) var isDetailsRefreshing = false
    private let urlDesserts = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private let urlDessertDetails = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    func filteredMeals(searchText: String) ->  [Meal] {
        if searchText.count == 0 {
            return self.meals
        } else{
            return self.meals.filter{ $0.strMeal.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    @MainActor
    func getDetails(id: String) async throws -> String{
        guard let urlDesserts = URL(string: urlDessertDetails + id) else{
            print("Invalid URL")
            return "Details not available"
        }
        print(urlDessertDetails + id)
        self.isDetailsRefreshing = true
        defer{isDetailsRefreshing = false}
        do {
            
            let (data, response) = try await URLSession.shared.data(from: urlDesserts)
            print(data)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode <= 300 else{
                
                throw UserError.invalidStatusCode
            }
            let decoder = JSONDecoder()
            guard let mealsWithDetails = try? decoder.decode(Meals.self, from: data) else{
                throw UserError.invalidStatusCode
            }
            mealsWithDetails.meals.first?.getIngrediatnsAndMeasures()
            
           
            
            
            return mealsWithDetails.meals.first?.strInstructions ?? "Description is not available"

        } catch{
            throw UserError.custom(error: error)
        }
        
    }
    
    
    
    @MainActor
    func fetchAllMeals() async throws {
        guard let urlDesserts = URL(string: urlDesserts) else{
            print("Invalid URL")
            return
        }
        self.isMealsRefreshing = true
        defer{isMealsRefreshing = false}
        
        do {
            
            let (data, response) = try await URLSession.shared.data(from: urlDesserts)
            print(data)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode <= 300 else{
                
                throw UserError.invalidStatusCode
            }
            let decoder = JSONDecoder()
            guard let meals = try? decoder.decode(Meals.self, from: data) else{
                throw UserError.invalidStatusCode
            }
            self.meals = meals.meals.sorted { $0.strMeal.lowercased() < $1.strMeal.lowercased()}
            
            
        } catch{
            throw UserError.custom(error: error)
        }
    }
}





    
    extension MealFetcher {
        
        enum UserError: LocalizedError{
            case custom( error: Error)
            case failedToDecode
            case invalidStatusCode
            var errorDescription: String?{
                switch self{
                case .failedToDecode:
                    return "Failed to Decode Response"
                case .custom(let error):
                    return error.localizedDescription
                case .invalidStatusCode:
                    return "Request fall within an invalid range"
                }
            }
        }
    }

