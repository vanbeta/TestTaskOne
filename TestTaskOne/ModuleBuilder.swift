//
//  ModuleBuilder.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 22.12.2022.
//

import UIKit

protocol Builder {
    static func createMain() -> UIViewController
    static func createEdit() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMain() -> UIViewController {
        let model = DataService()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, dataService: model)
        view.presenter = presenter
        return view
    }
    
    static func createEdit() -> UIViewController {
        let model = DataService()
        let view = EditViewController()
        let presenter = EditPresenter(view: view, dataService: model)
        view.presenter = presenter
        return view
    }
}
