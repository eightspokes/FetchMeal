//
//  MealFetcher.swift
//  FetchMeal
//
//  Created by Roman on 5/3/23.
//

import Foundation


class MealFetcher: ObservableObject {
    @Published var meals = [Meal]()
    @Published private(set) var isRefreshing = false
    private let urlDeserts = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
  
    @MainActor
    func fetchAllBreeds() async throws {
        guard let urlCatBreeds = URL(string: urlDeserts) else{
            print("Invalid URL")
            return
        }
        self.isRefreshing = true
        defer{isRefreshing = false}
        
        do {
            
            let (data, response) = try await URLSession.shared.data(from: urlCatBreeds)
            print(data)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode <= 300 else{
                
                throw UserError.invalidStatusCode
            }
            
            
            let decoder = JSONDecoder()
            guard let meals = try? decoder.decode(Meals.self, from: data) else{
                throw UserError.invalidStatusCode
            }
            self.meals = meals.meals
            
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

