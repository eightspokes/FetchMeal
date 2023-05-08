//
//  MealFetcher.swift
//  FetchMeal
//
//  Created by Roman on 5/3/23.
//
import Foundation
/**
    A class that handles fetching meals from a remote API, sorting them and filtering them based on a search query.
    The class conforms to the ObservableObject protocol, which allows SwiftUI views to automatically update themselves when the meals, errorMessage, hasError, and isLoading properties change.
 */
class MealFetcher: ObservableObject {
    
    @Published var meals = [Meal]()
    @Published var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var isLoading: Bool = false
    
    let apiService = APIService()
    let urlDesserts = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    let urlDessertDetails = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    //TODO: Implement tests using dependency injection
    let service: APIserviceProtocol
    init(service: APIserviceProtocol = APIService()){
        self.service = service
    }
    /**
     A function that filters an array of meals based on a search text string.
     
     - Parameter searchText: A string value representing the text to search for in the meal names.
     
     - Returns: An array of Meal objects that contain the search text string in their name. If the search text is an empty string, the function returns the original array of meals.
     */
    func filteredMeals(searchText: String) ->  [Meal] {
        if searchText.count == 0 {
            return self.meals
        } else{
            return self.meals.filter{ $0.strMeal.localizedCaseInsensitiveContains(searchText)}
        }
    }
    /**
     Fetches a meal description or array of meals from the API service with an optional meal id.
     If id is provided, the function uses the urlDessertDetails URL and fetches meal details.
     If id is not provided, the function uses the urlDesserts URL and fetches all meals and populates the meals array.
     
     - Parameter id: The optional id of the meal to fetch. If nil, fetches a list of meals.
     
     - Returns: The meal fetched from the API service, or nil if no meal is found.
     
     - Throws: APIError if there is an issue with the API service, such as a bad URL or bad response, or if there is an issue with parsing the data from the API.
     
     - Note: This function is asynchronous and should be called with the await keyword.
     
     - Important: This function should be called on the main actor, as indicated by the @MainActor attribute.
     */
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
