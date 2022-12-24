//
//  EditViewController.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 23.12.2022.
//

import UIKit

class EditViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var presenter: EditPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EditTableViewCell.self, forCellReuseIdentifier: "idCell")
        
        setTableView()
    }
    
    func setTableView() {
        self.view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension EditViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.profiles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell") as! EditTableViewCell
        
        cell.configure(profile: presenter?.profiles?[indexPath.row] ?? Profile(mainLabel: .firstName, datas: "Error"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension EditViewController: EditViewProtocol {
    func succes() {
        tableView.reloadData()
    }
}
