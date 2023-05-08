//
//  MealFetcher.swift
//  FetchMeal
//
//  Created by Roman on 5/3/23.
//

import Foundation

class MealFetcher: ObservableObject {

    @Published var meals = [Meal]()
    @Published var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = false
    let apiService = APIService()
    
    let urlDesserts = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    let urlDessertDetails = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    //For testing purpuses
    let service: APIserviceProtocol
    init(service: APIserviceProtocol = APIService()){
        self.service = service
    }
    
    
    func filteredMeals(searchText: String) ->  [Meal] {
        if searchText.count == 0 {
            return self.meals
        } else{
            return self.meals.filter{ $0.strMeal.localizedCaseInsensitiveContains(searchText)}
        }
    }
    @MainActor
    func fetchMeals(id: String? = nil) async -> Meal?  {
        var meal: Meal? = nil
        do{
            self.isLoading = true
            if let id {
                if let result = try await apiService.fetch(Meals.self, urlString: self.urlDessertDetails, id: id){
                    isLoading = false
                    meal = result.meals.first
                }
            }else{
                if let result = try await apiService.fetch(Meals.self, urlString: self.urlDesserts){
                    self.meals = result.meals.sorted { $0.strMeal.lowercased() < $1.strMeal.lowercased()}
                }
            }
        }catch APIError.badURL{
            self.hasError = true
            self.errorMessage = APIError.badURL.localizedDescription
            print(APIError.badURL.description)
        }catch APIError.parsing(let error){
            self.hasError = true
            self.hasError = true
            self.errorMessage = APIError.parsing(error).localizedDescription
            print(APIError.parsing(error).description)
            
        }catch APIError.badResponse(let statusCode){
            self.hasError = true
            self.errorMessage = APIError.badResponse(statusCode: statusCode).localizedDescription
            print(APIError.badResponse(statusCode: statusCode).description)
        }catch{
            self.hasError = true
            print(error.localizedDescription)
            self.errorMessage = APIError.unknown(error).localizedDescription
        }
        self.isLoading = false
        return meal
    }
}
