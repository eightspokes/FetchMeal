//
//  APIMockService.swift
//  FetchMeal
//
//  Created by Roman on 5/7/23.
//

import Foundation
//TODO: Use this service for Testing using dependency injection
struct APIMockService : APIserviceProtocol{
    var result: Meal
    func fetch<T>(_ type: T.Type, urlString: String, id: String? = nil) async throws -> T? where T : Decodable {
        return (self.result as! T)
    }
}
