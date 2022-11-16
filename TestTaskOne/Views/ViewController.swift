//
//  ViewController.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 14.11.2022.
//

import UIKit

class ViewController: UIViewController {

    

    let myNavigationBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: .zero)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()

    let myTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.green
        return tableView
    }()
    
    let data = ProfileDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.register(MyTableViewCell.self, forCellReuseIdentifier: "idCell")
        
        setNavigationBar()
        setTableView()
    }
    
    func setNavigationBar() {
        let navItem = UINavigationItem(title: "Просмотр")
        let doneItem = UIBarButtonItem(title: "Редактировать", style: .plain, target: nil, action: #selector(editBtn))

        navItem.rightBarButtonItem = doneItem

        myNavigationBar.setItems([navItem], animated: false)
        
        self.view.addSubview(myNavigationBar)
        
        myNavigationBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        myNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func setTableView() {
        self.view.addSubview(myTableView)

        myTableView.topAnchor.constraint(equalTo: myNavigationBar.bottomAnchor, constant: 0).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        myTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        myTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
    
    @objc
    func editBtn(){
        print("bingo")
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "idCell") as! MyTableViewCell
        
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

