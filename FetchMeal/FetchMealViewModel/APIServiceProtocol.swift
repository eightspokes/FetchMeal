//
//  APIServiceProtocol.swift
//  FetchMeal
//
//  Created by Roman on 5/7/23.
//

import Foundation
/**
 A protocol that defines the required method for fetching data from an API service.
 Fetches the data from the given URL string asynchronously and returns a decoded object of the specified type.
 - Parameters:
    - type: The type of the object that will be returned after decoding the fetched data.
    - urlString: The URL string for the API endpoint from where the data will be fetched.
    - id: An optional identifier for the data being fetched.
 
 - Returns: A decoded object of the specified type if the fetch and decoding process is successful, otherwise returns nil.
 
 - Throws: An error of type `Error` if there is an issue with the fetch or decoding process.
 */
protocol APIserviceProtocol{
    func fetch<T: Decodable>(_ type: T.Type, urlString: String, id: String?)  async throws -> T?
}
