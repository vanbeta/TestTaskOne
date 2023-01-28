//
//  ViewController.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 14.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var presenter: MainPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "idCell")
        
        setingsNavigationBar()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getProfiles()
        tableView.reloadData()
    }
    
    func setingsNavigationBar() {
        let btnEdit = UIBarButtonItem(title: "Редактировать", style: .plain, target: self, action: #selector(editBtn))
        navigationItem.title = "Просмотр"
        navigationItem.rightBarButtonItem = btnEdit
    }
    
    func setTableView() {
        self.view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    @objc
    func editBtn(){
        let editViewController = ModuleBuilder.createEdit()
        navigationController?.pushViewController(editViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.profiles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell") as! MainTableViewCell
        
        cell.configure(profile: presenter?.profiles?[indexPath.row] ?? Profile(mainLabel: .firstName, datas: "Error"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Protocol

extension MainViewController: MainViewProtocol {
    func succes() {
        tableView.reloadData()
    }
}
