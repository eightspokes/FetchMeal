//
//  APIError.swift
//  FetchMeal
//
//  Created by Roman on 5/5/23.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String{
        //user feedback
        switch self{
        case .badURL, .parsing, .unknown:
            return "Sorry, something went wrong"
        case .badResponse(_):
            return "Sorry, the connection to our server failed"
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong"
        }
        
    
    }
    var description: String{
        //info debugging
        switch self{
        case .unknown: return "Unknown error"
        case .badURL: return "Invalid URL"
        case .url(let error):
            return error?.localizedDescription ?? "url session error"
        case .parsing( let error):
            return "parsing error eroor \(error?.localizedDescription ?? "")"
        case.badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
        }
            
    }
}
