//
//  WriteReviewViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 05.08.2021..
//

import UIKit
import SVProgressHUD

class WriteReviewViewController: UIViewController {
    
    @IBOutlet private weak var ratingView: RatingView!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var commentField: UITextView!
    
    private let network = Network()
    var show: Model.Show?
    var authInfo: Model.AuthInfo?
    
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

// MARK: - setting up UI

private extension WriteReviewViewController {

    func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(didSelectClose)
        )
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.3985282183, green: 0.2966387272, blue: 0.6185286641, alpha: 1)
        
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

// MARK: - @IBActions

private extension WriteReviewViewController {
    
    @IBAction func didTapSubmitButton() {
        
        let params = ReviewParameters(
            rating: ratingView.rating,
            comment: commentField.text,
            show_id: Int(show!.id)!
        )
        
        network.submitShowReview(with: params, auth: authInfo!, statusHandler: { [weak self] isSuccesful in
            SVProgressHUD.dismiss()
            guard let self = self else { return }
            if isSuccesful {
                self.didSelectClose()
            } else {
                // TODO: - Create UIAlert
            }
        })
    }
}
