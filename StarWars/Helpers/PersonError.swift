//
//  PersonError.swift
//  StarWars
//
//  Created by LAURA JELENICH on 9/24/20.
//

import Foundation

enum PersonError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    
    var errorDescription: String? {
        switch self {
        
        case .invalidURL:
            return "The server failed to reach the url"
        case .thrownError(let error):
            return "Could not display the data: \(error.localizedDescription)"
        case .noData:
            return "No data found"
        }
    }
}
