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

    public let textField: UITextField = {
        let myTextFiel = UITextField()
        myTextFiel.translatesAutoresizingMaskIntoConstraints = false
        myTextFiel.textAlignment = .right
        myTextFiel.placeholder = "Введите данные"
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
        myTextView.isScrollEnabled = false
        myTextView.font = UIFont.systemFont(ofSize: 17)
        return myTextView
    }()
    
    let standartIndent: CGFloat = 10
    
    var textViewChanged: ((String) -> Void)?
    var textFieldChanged: ((String) -> Void)?
    var datePickerChanged: ((String) -> Void)?
    
    let pickerData = ["мужской", "женский", "не выбрано"]

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textView.delegate = self
        textField.delegate = self

        createNameLabel()
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    func datePickerChanged(action: @escaping (String) -> Void) {
        self.datePickerChanged = action
    }
    
    @objc
    func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let date = formatter.string(from: datePicker.date)
        datePickerChanged?(date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: standartIndent).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true
        
        nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }

    func createRightWidjet(widget: UIView) {
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
            createRightWidjet(widget: textField)
            textField.text = profile.datas == "Нет данных" ? nil : profile.datas
        case .lastName:
            nameLabel.text = "Фамилия"
            createRightWidjet(widget: textView)
            textView.text = profile.datas == "Нет данных" ? nil : profile.datas
        case .patronymic:
            nameLabel.text = "Отчество"
            createRightWidjet(widget: textField)
            textField.text = profile.datas == "Нет данных" ? nil : profile.datas
        case .date:
            nameLabel.text = "Дата рождения"
            createRightWidjet(widget: datePicker)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let date = formatter.date(from: profile.datas)
            guard let date = date else { return }
            self.datePicker.setDate(date, animated: false)
        case .sex:
            nameLabel.text = "Пол"
            createRightWidjet(widget: textField)
            createPickerView(textField: textField)
            textField.text = profile.datas
        }
    }
}

extension EditTableViewCell: UITextFieldDelegate {
    func textFieldChanged(action: @escaping (String) -> Void) {
        self.textFieldChanged = action
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldChanged?(textField.text ?? "")
    }
}

extension EditTableViewCell: UITextViewDelegate {
    func textChanged(action: @escaping (String) -> Void) {
        self.textViewChanged = action
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textViewChanged?(textView.text)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите данные"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension EditTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = pickerData[row]
        self.endEditing(true)
    }
    
    func createPickerView(textField: UITextField) {
        let myPickerView = UIPickerView()
        myPickerView.delegate = self
        textField.inputView = myPickerView
    }
}
