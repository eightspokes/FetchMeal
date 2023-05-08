//
//  APIError.swift
//  FetchMeal
//
//  Created by Roman on 5/5/23.
//

import Foundation
/**
    A custom error type that represents different types of errors that can occur during an API call.
*/
enum APIError: Error, CustomStringConvertible, LocalizedError {
    case badURL
    case badResponse(statusCode: Int)
    case parsing(Error)
    case unknown(Error)
    
    var localizedDescription: String{
        //user feedback
        switch self{
        case .badURL, .parsing, .unknown:
            return "Sorry, something went wrong"
        case .badResponse(_):
            return "Sorry, the connection to our server failed"
        }
    }
    var description: String{
        switch self{
        case .unknown(let error): return "Unknown error \(error.localizedDescription)"
        case .badURL: return "Invalid URL"
        case .parsing( let error):
            return "\(error.localizedDescription)"
        case.badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
        }
    }
}
