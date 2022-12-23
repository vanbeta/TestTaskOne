//
//  ViewController.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 14.11.2022.
//

import UIKit

class MainViewController: UIViewController {

    let myTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var presenter: MainPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(MyTableViewCell.self, forCellReuseIdentifier: "idCell")
        
        setingsNavigationBar()
        setTableView()
    }
    
    func setingsNavigationBar() {
        let btnEdit = UIBarButtonItem(title: "Редактировать", style: .plain, target: self, action: #selector(editBtn))
        navigationItem.title = "Просмотр"
        navigationItem.rightBarButtonItem = btnEdit
    }
    
    func setTableView() {
        self.view.addSubview(myTableView)

        myTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    @objc
    func editBtn(){
        print("bingo")
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.profiles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "idCell") as! MyTableViewCell
        
        cell.configure(profile: presenter?.profiles?[indexPath.row] ?? Profile(mainLabel: .firstName, datas: "Error"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: MainViewProtocol {
    func succes() {
        myTableView.reloadData()
    }
}
