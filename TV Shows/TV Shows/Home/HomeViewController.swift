//
//  HomeViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 20.07.2021..
//

import UIKit
import Alamofire
import SVProgressHUD

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var shows: [Show] = []
    private let network = Network()
    private var notificationToken: NSObjectProtocol?
    var userResponse: UserResponse?
    var authInfo: AuthInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getShowsList()
        
        // Add navigation item
        let profileDetailsItem = UIBarButtonItem(
            image: UIImage(named: "ic-profile"),
            style: .plain,
            target: self,
            action: #selector(profileDetailsActionHandler)
        )
        
        profileDetailsItem.tintColor = #colorLiteral(red: 0.3985282183, green: 0.2966387272, blue: 0.6185286641, alpha: 1)
        navigationItem.rightBarButtonItem = profileDetailsItem
        
        notificationToken = NotificationCenter
            .default
            .addObserver(
                forName: Notification.Name(Constants.Notification.didLogout.rawValue),
                object: nil,
                queue: nil,
                using: { [weak self] _ in
                    guard let self = self else { return }
                    
                    let loginStoaryboard = UIStoryboard(name: "Login", bundle: nil)
                    let loginViewController = loginStoaryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.navigationController?.setViewControllers([loginViewController], animated: true)
                }
            )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc
    private func profileDetailsActionHandler() {
        network.getMyInfo(with: authInfo!, statusHandler: { [weak self] response in
            guard let self = self else { return }
            
            let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
            let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            let navController = UINavigationController(rootViewController: profileViewController)
            profileViewController.user = response.user
            profileViewController.authInfo = self.authInfo
            self.present(navController, animated:true)
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(notificationToken!)
    }
}


// MARK: - UI setup

private extension HomeViewController {

    func getShowsList() {
        SVProgressHUD.show()
        network.getShow(with: authInfo!, statusHandler: { [weak self] r in
            guard let self = self else { return }
            SVProgressHUD.dismiss()
            switch r.result {
                case .success(let response):
                    self.shows = response.shows
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.errorDescription!)
                }
        })
    }
    
    func navigateToShowDetails(for show: Show) {
        let storyboard = UIStoryboard(name: "ShowDetails", bundle: .main)
        let showDetailsViewController = storyboard.instantiateViewController(
            withIdentifier: String(describing: ShowDetailsViewController.self)
        ) as! ShowDetailsViewController
        showDetailsViewController.show = show
        showDetailsViewController.authInfo = authInfo
        navigationController?.pushViewController(showDetailsViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = String(describing: ShowTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! ShowTableViewCell
        let show = shows[indexPath.row]
        cell.show = show
        cell.configure(with: show)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let show = shows[indexPath.row]
        navigateToShowDetails(for: show)
    }
}
