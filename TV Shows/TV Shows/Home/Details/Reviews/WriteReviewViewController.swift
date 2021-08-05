//
//  WriteReviewViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 05.08.2021..
//

import UIKit

class WriteReviewViewController: UIViewController {
    
    @IBOutlet private weak var ratingView: RatingView!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var commentField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
       
    @objc private func didSelectClose() {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

private extension WriteReviewViewController {

    func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(didSelectClose)
        )
        
        ratingView.configure(withStyle: .large)
        ratingView.isEnabled = true
        
        submitButton.layer.cornerRadius = 21.5
        submitButton.clipsToBounds = true
        
        commentField.layer.cornerRadius = 10
        commentField.clipsToBounds = true
        commentField.textContainerInset = UIEdgeInsets(
            top: 15,
            left: 15,
            bottom: 15,
            right: 15
        )
        
    }
}
