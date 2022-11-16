//
//  MyTableViewCell.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 15.11.2022.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    
    
    let nameLabel: UILabel = {
        let myNameLabel = UILabel()
        myNameLabel.translatesAutoresizingMaskIntoConstraints = false
        myNameLabel.backgroundColor = .lightGray
        return myNameLabel
    }()
    
    let textField: UITextField = {
        let myTextFiel = UITextField()
        myTextFiel.translatesAutoresizingMaskIntoConstraints = false
        myTextFiel.textAlignment = .right
        myTextFiel.backgroundColor = .lightGray
        return myTextFiel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setNameLabel()
        setTextField()
        textField.placeholder = "Введите данные"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // TODO: сделать ччтобы занимало пропорцианально лейбл 1/3 экрана осталоьно текстФилд
    func setNameLabel() {
        contentView.addSubview(nameLabel)
        
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func setTextField() {
        contentView.addSubview(textField)
        
        textField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func configure() {
        nameLabel.text = "Имя"
        textField.text = "Иван"
    }
}
