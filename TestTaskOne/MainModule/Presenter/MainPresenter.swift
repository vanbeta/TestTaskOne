//
//  Presenter.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 14.11.2022.
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    func succes()
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, dataService: DataServiceProtocol)
    func getProfiles()
    var profiles: [Profile]? { get set }
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var dataService: DataServiceProtocol?
    var profiles: [Profile]?
    
    required init(view: MainViewProtocol, dataService: DataServiceProtocol) {
        self.view = view
        self.dataService = dataService
        getProfiles()
    }
    
    func getProfiles() {
        dataService?.getProfiles { [weak self] result in
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
