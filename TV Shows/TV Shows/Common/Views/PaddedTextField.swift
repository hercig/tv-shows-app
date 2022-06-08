//
//  CustomTextField.swift
//  TV Shows
//
//  Created by Filip Hercig on 20.07.2021..
//

import UIKit
import SnapKit

final class PaddedTextField: UITextField {

    private let padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0);

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // MARK: - Style
    
    func addBottomLine() {
        let line = UIView()
        line.backgroundColor = .white
        
        textInputView.addSubview(line)
        
        line.snp.remakeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func addAtributtedPlaceholder(_ title: String) {
        attributedPlaceholder = NSAttributedString(
            string: title,
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
    }
    
    func startIncorrectCredentialsAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 10, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 10, y: center.y))

        layer.add(animation, forKey: "position")
    }
}
