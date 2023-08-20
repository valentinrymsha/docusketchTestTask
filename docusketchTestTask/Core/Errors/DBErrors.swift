//
//  DBErrors.swift
//  docusketchTestTask
//
//  Created by Valentin on 20.08.23.
//

import Foundation

enum DBErrors: Error {
    
    case accessDBError
    case notExistDBError
    
}

extension DBErrors: LocalizedError {
    
    var localDescription: String {
        
        switch self {
        case .accessDBError:
            return "No access"
        case .notExistDBError:
            return "DB not exist yet"
        
        }
    }
}
