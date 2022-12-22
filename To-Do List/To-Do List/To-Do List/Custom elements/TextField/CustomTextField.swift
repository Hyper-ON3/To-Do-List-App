//
//  CustomTextField.swift
//  To-Do List
//
//  Created by Aleksey Kotsevych on 11/12/2022.
//

import UIKit

protocol CustomTextFieldDelegate {
    func createTaskButtonTapped(_ task: String?)
}

class CustomTextField: BaseUIViewComponent {
    
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet var mainView: UIView!
    
    var delegate: CustomTextFieldDelegate?
    
    func configuringCustomTFElements() {
        button.clipsToBounds = true
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        
        textFieldView.clipsToBounds = true
        textFieldView.layer.cornerRadius = 12

    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if textField.text != "" {
            delegate?.createTaskButtonTapped(textField.text)
        }
    }
}
