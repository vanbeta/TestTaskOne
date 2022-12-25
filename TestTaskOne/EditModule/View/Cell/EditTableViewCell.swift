//
//  EditTableViewCell.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 24.12.2022.
//

import UIKit

class EditTableViewCell: UITableViewCell {
    let nameLabel: UILabel = {
        let myNameLabel = UILabel()
        myNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return myNameLabel
    }()

    let textField: UITextField = {
        let myTextFiel = UITextField()
        myTextFiel.translatesAutoresizingMaskIntoConstraints = false
        myTextFiel.textAlignment = .right
        return myTextFiel
    }()

    let datePicker: UIDatePicker = {
        let myDatePicker = UIDatePicker()
        myDatePicker.translatesAutoresizingMaskIntoConstraints = false
        myDatePicker.datePickerMode = UIDatePicker.Mode.date
        let now = Date();
        myDatePicker.maximumDate = now
        return myDatePicker
    }()

    let textView: UITextView = {
        let myTextView = UITextView()
        myTextView.translatesAutoresizingMaskIntoConstraints = false
        myTextView.textAlignment = .right
        myTextView.backgroundColor = .lightGray
        myTextView.isScrollEnabled = false
        myTextView.font = UIFont.systemFont(ofSize: 17)
        return myTextView
    }()

    let standartIndent: CGFloat = 10
    var textChanged: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textView.delegate = self

        setNameLabel()
//        textField.placeholder = "Введите данные"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: standartIndent).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
        
        nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
    }

    func setRightWidjet(widget: UIView) {
        contentView.addSubview(widget)
        widget.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -standartIndent).isActive = true
        widget.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        widget.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        widget.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
    }

    func configure(profile: Profile) {
        switch profile.mainLabel {
        case .firstName:
            nameLabel.text = "Имя"
            setRightWidjet(widget: textField)
            textField.text = profile.datas
        case .lastName:
            nameLabel.text = "Фамилия"
            setRightWidjet(widget: textView)
//            textView.text = profile.datas
            textView.text = "ФамилияФамилияdlksjdkaskda;c;return UITableView.automaticDimensionreturn UITableView.automaticDimension"
        case .patronymic:
            nameLabel.text = "Отчество"
            setRightWidjet(widget: textField)
            textField.text = profile.datas
        case .date:
            nameLabel.text = "Дата рождения"
//            setDatePicker()
            setRightWidjet(widget: datePicker)
        case .sex:
            nameLabel.text = "Пол"
            // use picker
//            textField.text = profile.datas
        }
    }
}

extension EditTableViewCell: UITextViewDelegate {
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
}
