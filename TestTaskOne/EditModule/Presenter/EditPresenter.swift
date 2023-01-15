//
//  EditPresenter.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 23.12.2022.
//

import Foundation

protocol EditViewProtocol: AnyObject {
    func succes()
}

protocol EditPresenterProtocol: AnyObject {
    init(view: EditViewProtocol, dataService: DataServiceProtocol)
    var profiles: [Profile]? { get set }
    func 	updateData(data: Profile)
}

class EditPresenter: EditPresenterProtocol {
    weak var view: EditViewProtocol?
    var data: DataServiceProtocol?
    var profiles: [Profile]?
    
    required init(view: EditViewProtocol, dataService: DataServiceProtocol) {
        self.view = view
        self.data = dataService
        getProfiles()
    }
    
    func getProfiles() {
        data?.getProfiles { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let profiles):
                    self.profiles = profiles
                    self.view?.succes()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func updateData(data: Profile) {
        if let index = profiles?.firstIndex(where: ({$0.mainLabel == data.mainLabel})) {
            profiles![index].datas = data.datas
        }
        
        for i in profiles! {
            print("name \(i.mainLabel) = \(i.datas)")
        }
    }
}
