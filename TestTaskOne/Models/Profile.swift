//
//  Profile.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 14.11.2022.
//

import Foundation

struct Profile { // плохое название
    
    enum MainLabel: String {
        case firstName = "Имя"
        case lastName = "Фамилия"
        case patronymic = "Отчество"
        case date = "Дата"
        case sex = "Пол"
    }
    
    var mainLabel: MainLabel
    var datas: String
}

class ProfileDataManager {

    let data = [Profile(mainLabel: .firstName, datas: "Иван"),
                Profile(mainLabel: .lastName, datas: "Иванов"),
                Profile(mainLabel: .patronymic, datas: "Иванович"),
                Profile(mainLabel: .date, datas: "66.66.6666"),
                Profile(mainLabel: .sex, datas: "Мужской")]
}
