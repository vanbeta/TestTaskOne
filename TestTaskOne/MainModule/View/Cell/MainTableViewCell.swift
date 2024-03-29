//
//  MainTableViewCell.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 15.11.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    let nameLabel: UILabel = {
        let myNameLabel = UILabel()
        myNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return myNameLabel
    }()
    
    let dataLabel: UILabel = {
        let myDataLabel = UILabel()
        myDataLabel.translatesAutoresizingMaskIntoConstraints = false
        myDataLabel.textAlignment = .right
        myDataLabel.isEnabled = false
        return myDataLabel
    }()
    
    let standartIndent: CGFloat = 10
    let standartHieght: CGFloat = 50
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setNameLabel()
        setTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNameLabel() {
        contentView.addSubview(nameLabel)
        
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: standartIndent).isActive = true
        
        nameLabel.heightAnchor.constraint(equalToConstant: standartHieght).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func setTextField() {
        contentView.addSubview(dataLabel)
        
        dataLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -standartIndent).isActive = true
        
        dataLabel.heightAnchor.constraint(equalToConstant: standartHieght).isActive = true
        dataLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
                
        dataLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func configure(profile: Profile) {
        switch profile.mainLabel {
        case .firstName:
            nameLabel.text = profile.mainLabel.rawValue
            dataLabel.text = profile.datas
        case .lastName:
            nameLabel.text = profile.mainLabel.rawValue
            dataLabel.text = profile.datas
        case .patronymic:
            nameLabel.text = profile.mainLabel.rawValue
            dataLabel.text = profile.datas
        case .date:
            nameLabel.text = profile.mainLabel.rawValue
            dataLabel.text = profile.datas
        case .sex:
            nameLabel.text = profile.mainLabel.rawValue
            dataLabel.text = profile.datas
        }
    }
}
