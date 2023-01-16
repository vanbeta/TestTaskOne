//
//  EditPresenter.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 23.12.2022.
//

import Foundation

protocol EditViewProtocol: AnyObject {
    func succes()
    func showAlert(with title: String, and message: String)
}

protocol EditPresenterProtocol: AnyObject {
    init(view: EditViewProtocol, dataService: DataServiceProtocol)
    var profiles: [Profile]? { get set }
    func updateData(data: Profile)
    func saveBtnPressed()
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
    }
    
    func saveBtnPressed() {
        guard let profiles = profiles else { return }
        for i in profiles {
            switch i.mainLabel {
            case .firstName:
                if i.datas.isEmpty {
                    view?.showAlert(with: "Ошибка", and: "Возможно поле имя или фамилия не заполненны")
                    return
                }
            case .lastName:
                if i.datas.isEmpty {
                    view?.showAlert(with: "Ошибка", and: "Возможно поле имя или фамилия не заполненны")
                    return
                }
            case .sex:
                if i.datas.isEmpty || i.datas == "не выбрано" {
                    view?.showAlert(with: "Ошибка", and: "Возможно поле имя или фамилия или пол не заполненны")
                    return
                }
            case .patronymic, .date: break
            default:
                return
            }
        }
        data?.saveProfiles(profiles: profiles)
    }
}
