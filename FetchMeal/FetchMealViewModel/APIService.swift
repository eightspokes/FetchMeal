//
//  APIService.swift
//  FetchMeal
//
//  Created by Roman on 5/7/23.
//

import Foundation
/**
 Fetches data from the given URL using the specified type and ID.
 - Parameters:
 - type: The type of the data to decode.
 - urlString: The URL to fetch data from.
 - id: The ID to append to the URL, if any.
 
 - Returns: A decoded instance of the specified type, or nil if the decoding fails.
 
 - Throws: An `APIError` if there is an issue with the URL, response status code, or data parsing.
 
 - Note: This function executes asynchronously.
 
 */
struct APIService: APIserviceProtocol {
    
    func fetch<T: Decodable>(_ type: T.Type, urlString: String, id: String? = nil)  async throws -> T? {
        guard let urlDesserts = URL(string: (id == nil) ? urlString : urlString + id!) else{
            print("Invalid URL")
            throw APIError.badURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: urlDesserts)
            if let response = response as? HTTPURLResponse{
                if  !(response.statusCode >= 200 && response.statusCode <= 300){
                    throw APIError.badResponse(statusCode: response.statusCode)
                }
            }
            let decoder = JSONDecoder()
            let result = try? decoder.decode(type, from: data)
            
            return result
        } catch{
            throw APIError.parsing(error)
        }
    }
}
