//
//  СheckError.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 02.02.2023.
//

import Foundation


enum CheckError: Error {
    case firstNameEmpty
    case lastNameEmpty
    case dateEmpty
    case sexEmpty
}

extension CheckError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .firstNameEmpty:
            return NSLocalizedString("Поле имя не заполнено", comment: "")
        case .lastNameEmpty:
            return NSLocalizedString("Поле фамилия не заполнено", comment: "")
        case .dateEmpty:
            return NSLocalizedString("Поле дата рождения не заполнено", comment: "")
        case .sexEmpty:
            return NSLocalizedString("Поле пол не заполненом", comment: "")
        }
    }
}
