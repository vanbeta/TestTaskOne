//
//  CustomTextFieldForPickerView.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 20.01.2023.
//

import UIKit

class CustomTextFieldForPickerView: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        !isFirstResponder
    }
}
