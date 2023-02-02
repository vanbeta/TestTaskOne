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
    func showRemoveAlert(with title: String, and message: String,  _ completion: @escaping (Bool) -> ())
    func backViewController()
}

protocol EditPresenterProtocol: AnyObject {
    init(view: EditViewProtocol, dataService: DataServiceProtocol)
    var profiles: [Profile]? { get set }
    var temporaryProfiles: [Profile]? { get set }
    func updateData(data: Profile)
    func saveBtnPressed()
    func btnBackPressed()
}

class EditPresenter: EditPresenterProtocol {
    private weak var view: EditViewProtocol?
    private var data: DataServiceProtocol?
    var profiles: [Profile]?
    var temporaryProfiles: [Profile]?
    
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
                    self.temporaryProfiles = profiles
                    self.view?.succes()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func updateData(data: Profile) {
        if let index = temporaryProfiles?.firstIndex(where: ({$0.mainLabel == data.mainLabel})) {
            temporaryProfiles![index].datas = data.datas
        }
    }
    
    func saveBtnPressed() {
        guard let temporaryProfiles = temporaryProfiles else { return }
          
        checkFields(temporaryProfiles: temporaryProfiles) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                if profiles != temporaryProfiles {
                    data?.saveProfiles(profiles: temporaryProfiles)
                    profiles = temporaryProfiles
                }
            case .failure(let error):
                self.view?.showAlert(with: "Ошибка", and: error.localizedDescription)
        }
        }
    }
        
    private func checkFields(temporaryProfiles: [Profile] ,complition: (Result<Bool, Error>) -> ()) {
        var ok = true
        for i in temporaryProfiles {
            switch i.mainLabel {
            case .firstName:
                if i.datas.isEmpty || i.datas == "Нет данных" {
                    complition(.failure(CheckError.firstNameEmpty))
                    ok.toggle()
                    return
                }
            case .lastName:
                if i.datas.isEmpty || i.datas == "Нет данных" {
                    complition(.failure(CheckError.lastNameEmpty))
                    ok.toggle()
                    return
                }
            case .date:
                if i.datas.isEmpty || i.datas == "не выбрано" || i.datas == "Нет данных" {
                    complition(.failure(CheckError.dateEmpty))
                    ok.toggle()
                    return
                }
            case .sex:
                if i.datas.isEmpty || i.datas == "не выбрано" || i.datas == "Нет данных" {
                    complition(.failure(CheckError.sexEmpty))
                    ok.toggle()
                    return
                }
            default: break
            }
        }
        if ok { complition(.success(true)) }
    }
    
    func btnBackPressed() {
        if profiles != temporaryProfiles {
            view?.showRemoveAlert(with: "Внимание", and: "Были внесены измения") { [weak self] ok in
                guard let self = self else { return }
                if ok { self.saveBtnPressed() }
                self.view?.backViewController()
            }
        } else {
            self.view?.backViewController()
        }
    }
}

