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
    private var isEditingData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EditTableViewCell.self, forCellReuseIdentifier: "idEditCell")
        
        settingsNavigationBar()
        setTableView()
    }
    
    func settingsNavigationBar() {
        let btnEdit = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveBtn))
        navigationItem.title = "Редактировать"
        navigationItem.rightBarButtonItem = btnEdit
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.setTitle("Назад", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(btnBack), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func setTableView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    @objc
    func btnBack() {
        presenter.btnBackPressed()
    }
    
    @objc
    func saveBtn(){
        presenter.saveBtnPressed()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension EditViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.profiles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idEditCell") as! EditTableViewCell
        
        let profile = presenter?.profiles?[indexPath.row]
        
        cell.configure(profile: profile ?? Profile(mainLabel: .firstName, datas: "Error"))
        cell.editTableViewCellProtocol = self
        cell.iDCell = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Extension

extension EditViewController: EditViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func backViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension EditViewController: EditTableViewCellProtocol {
    func didPressed(str: String, id: Int) {
        let profile = presenter?.profiles?[id]
        guard let profile = profile else { return }
        self.presenter.updateData(data: Profile(mainLabel: profile.mainLabel, datas: str))
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

