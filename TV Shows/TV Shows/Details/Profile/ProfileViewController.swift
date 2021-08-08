//
//  ProfileViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.08.2021..
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var profileImage: UIImageView!
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func didSelectClose() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UISetup

private extension ProfileViewController {
    
    func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(didSelectClose)
        )
        
        emailLabel.text = user.email
        profileImage.kf.setImage(
            with: URL(string: user.imageUrl ?? ""),
            placeholder: UIImage(named: "ic-profile-placeholder")
        )
        
    }
}

// MARK: - @IBActions

private extension ProfileViewController {
    
    @IBAction func didPressChangeProfilePhoto() {
        // DO SOMETHING
    }
}
