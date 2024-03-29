//
//  Profile.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 14.11.2022.
//

import Foundation

struct Profile: Equatable {
    enum MainLabel: String {
        case firstName = "Имя"
        case lastName = "Фамилия"
        case patronymic = "Отчество"
        case date = "Дата"
        case sex = "Пол"
    }
    var mainLabel: MainLabel
    var datas: String
    
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.mainLabel == rhs.mainLabel && lhs.datas == rhs.datas
    }
}
