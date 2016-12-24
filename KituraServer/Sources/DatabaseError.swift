//
//  DatabaseError.swift
//  KituraServer
//
//  Created by Tomas Sergeant on 23/12/16.
//
//

import Foundation
enum DatabaseError: Error {
    
    case noConnection
    case noResult
    case invalidLengthQuery(String)
    case insertionProblem
    case badRequest
    case databaseError(String)
    
}

extension DatabaseError: LocalizedError {
    
    var errorDescription: String? {
        
        switch self {
            
        case .noConnection:
            return "Could not make a connection"
            
        case .noResult:
            return "Database returned no result"
            
        case .invalidLengthQuery(let query):
            return "\(query) was too short"
            
        case .insertionProblem:
            return "Could not insert the element"
            
        case .badRequest:
            return "There was a bad request"
            
        case .databaseError(let message):
            return "Database error: \(message)"
        }
        
    }
    
}
