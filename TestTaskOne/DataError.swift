//
//  DataError.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 13.01.2023.
//

import Foundation

enum ErrorResult {
    case success
    case failure(Error)
}

enum DataError {
    case emptyName
    case emptyLastName
    case emptySex
}

extension DataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyName:
            return NSLocalizedString("Field name is empty", comment: "")
        case .emptyLastName:
            return NSLocalizedString("Field last name is empty", comment: "")
        case .emptySex:
            return NSLocalizedString("Field sex is empty", comment: "")
        }
    }
}
