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
    let network = Network()
    var userResponse: UserResponse?
    var authInfo: AuthInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getShowsList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: false)
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
