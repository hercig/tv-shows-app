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
    @IBOutlet private weak var logoutButton: UIButton!
    
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
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.3985282183, green: 0.2966387272, blue: 0.6185286641, alpha: 1)
        
        emailLabel.text = user.email
        profileImage.kf.setImage(
            with: URL(string: user.imageUrl ?? ""),
            placeholder: UIImage(named: "ic-profile-placeholder")
        )
        logoutButton.layer.cornerRadius = 21.5
        logoutButton.clipsToBounds = true
    }
}

// MARK: - @IBActions

private extension ProfileViewController {
    
    @IBAction func didPressChangeProfilePhoto() {
        // DO SOMETHING
    }
}
