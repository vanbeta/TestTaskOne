//
//  DataService.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 22.12.2022.
//

import Foundation

protocol DataServiceProtocol: AnyObject {
    func getProfiles(compition: @escaping (Result<[Profile]?, Error>) -> ())
    func saveProfiles(profiles: [Profile])
}

class DataService: DataServiceProtocol {
    func getProfiles(compition: @escaping (Result<[Profile]?, Error>) -> ()) {
        var data: [Profile] = []
        
        let noData = "Нет данных"

        data.append(Profile(mainLabel: .firstName,
                            datas: UserDefaults.standard.string(forKey: Profile.MainLabel.firstName.rawValue)
                            ?? noData))
        data.append(Profile(mainLabel: .lastName,
                            datas: UserDefaults.standard.string(forKey: Profile.MainLabel.lastName.rawValue)
                            ?? noData))
        data.append(Profile(mainLabel: .patronymic,
                            datas: UserDefaults.standard.string(forKey: Profile.MainLabel.patronymic.rawValue)
                            ?? noData))
        data.append(Profile(mainLabel: .date,
                            datas: UserDefaults.standard.string(forKey: Profile.MainLabel.date.rawValue)
                            ?? noData))
        data.append(Profile(mainLabel: .sex,
                            datas: UserDefaults.standard.string(forKey: Profile.MainLabel.sex.rawValue)
                            ?? noData))
        
        compition(.success(data))
    }
    
    func saveProfiles(profiles: [Profile]) {
        for p in profiles {
            UserDefaults.standard.set(p.datas, forKey: p.mainLabel.rawValue)
        }
    }
}
