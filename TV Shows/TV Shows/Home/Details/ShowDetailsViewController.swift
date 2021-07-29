//
//  ShowDetailsViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 29.07.2021..
//

import UIKit

class ShowDetailsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var show: Show?
    var authInfo: AuthInfo?
    let network = Network()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.title = show?.title
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        network.getReviews(for: show!, with: authInfo!, statusHandler: { r in
            switch r.result {
            case .success(let result):
                print("Jej")
            case .failure(let error):
                print("______________________________")
                print(r)
                print(error.errorDescription)
                print(error.responseCode)
                print("______________________________")
            }
        })
    }
}

extension ShowDetailsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let noOfReviews = show?.noOfReviews else { return 0 }
        return noOfReviews + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellName = String(describing: ShowInfoTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! ShowInfoTableViewCell
            cell.configure(with: show!)
            return cell
        } else {
            let cellName = String(describing: ShowReviewsTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! ShowReviewsTableViewCell
            cell.configure(with: show!)
            return cell
        }
    }
}
