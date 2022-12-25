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
}
