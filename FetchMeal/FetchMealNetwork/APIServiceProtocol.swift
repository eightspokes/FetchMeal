//
//  APIServiceProtocol.swift
//  FetchMeal
//
//  Created by Roman on 5/7/23.
//

import Foundation

protocol APIserviceProtocol{
    func fetch<T: Decodable>(_ type: T.Type, urlString: String, id: String?)  async throws -> T?
}
