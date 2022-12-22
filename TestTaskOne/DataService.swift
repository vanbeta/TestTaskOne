//
//  DataService.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 22.12.2022.
//

import Foundation

protocol DataServiceProtocol: AnyObject {
    func getProfiles(compition: @escaping (Result<[Profile]?, Error>) -> ())
}

class DataService: DataServiceProtocol {
    let data = [Profile(mainLabel: .firstName, datas: "Иван"),
                Profile(mainLabel: .lastName, datas: "Иванов"),
                Profile(mainLabel: .patronymic, datas: "Иванович"),
                Profile(mainLabel: .date, datas: "66.66.6666"),
                Profile(mainLabel: .sex, datas: "Мужской")]
    
    func getProfiles(compition: @escaping (Result<[Profile]?, Error>) -> ()) {
            compition(.success(data))
    }
}
