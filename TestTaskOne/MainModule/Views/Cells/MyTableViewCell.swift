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
        return myNameLabel
    }()
    
    let textField: UITextField = {
        let myTextFiel = UITextField()
        myTextFiel.translatesAutoresizingMaskIntoConstraints = false
        myTextFiel.textAlignment = .right
        myTextFiel.isEnabled = false
        return myTextFiel
    }()
    
    let standartIndent: CGFloat = 10
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setNameLabel()
        setTextField()
        textField.placeholder = "Введите данные"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNameLabel() {
        contentView.addSubview(nameLabel)
        
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: standartIndent).isActive = true
        
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func setTextField() {
        contentView.addSubview(textField)
        
        textField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -standartIndent).isActive = true
        
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
                
        textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func configure(profile: Profile) {
        switch profile.mainLabel {
        case .firstName:
            nameLabel.text = "Имя"
            textField.text = profile.datas
        case .lastName:
            nameLabel.text = "Фамилия"
            textField.text = profile.datas
        case .patronymic:
            nameLabel.text = "Отчество"
            textField.text = profile.datas
        case .date:
            nameLabel.text = "Дата рождения"
            textField.text = profile.datas
        case .sex:
            nameLabel.text = "Пол"
            textField.text = profile.datas
        }
    }
}
