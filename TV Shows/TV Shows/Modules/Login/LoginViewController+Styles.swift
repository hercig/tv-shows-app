//
//  LoginViewStyles.swift
//  TV Shows
//
//  Created by Filip Hercig on 20.07.2021..
//

import UIKit

extension LoginViewController {
    
    func editTextFieldStyle(of field: UITextField, placeholder: String = "") {
        
        // Changing placeholder opacity
        let placeholderText = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        field.attributedPlaceholder = placeholderText
        
        // Adding bottom border line
        field.layer.shadowColor = UIColor.white.cgColor
        field.layer.shadowOffset = CGSize(width: 0, height: 1)
        field.layer.shadowOpacity = 1
        field.layer.shadowRadius = 0
    }
    
    func roundButtonEdges(of button: UIButton) {
        button.layer.cornerRadius = 21.5
        button.clipsToBounds = true
    }
}
