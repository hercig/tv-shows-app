//
//  CustomTextField.swift
//  TV Shows
//
//  Created by Filip Hercig on 20.07.2021..
//

import UIKit

final class PaddedTextField: UITextField {

    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10);

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
