//
//  ShowDetailsViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 29.07.2021..
//

import UIKit
import SVProgressHUD

class ShowDetailsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var show: Model.Show?
    var authInfo: AuthInfo?
    private var reviews: [Model.Review] = []
    private let network = Network()
    
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
        network.getReviews(for: show!, with: authInfo!, statusHandler: { [weak self] r in
            guard let self = self else { return }
            switch r.result {
                case .success(let result):
                    self.reviews = result.reviews
                    SVProgressHUD.dismiss()
                    self.tableView.reloadData()
                case .failure(let error):
                    SVProgressHUD.dismiss()
                    print(error.errorDescription ?? "")
            }
        })
    }
}

extension ShowDetailsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let noOfReviews = reviews.count + 2
        return noOfReviews
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellName = String(describing: ShowInfoTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! ShowInfoTableViewCell
            cell.configure(with: show!)
            return cell
        } else if indexPath.row < reviews.count + 1 {
            let cellName = String(describing: ShowReviewsTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! ShowReviewsTableViewCell
            cell.configure(with: reviews[indexPath.row - 1])
            return cell
        } else {
            let cellName = String(describing: WriteReviewTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! WriteReviewTableViewCell
            return cell
        }
    }
}

extension ShowDetailsViewController {
    
    @IBAction func didTapWriteReviewButton (_ sender: Any) {
        
        let reviewStoryboard = UIStoryboard(name: "WriteReview", bundle: nil)
        let writeReviewVC = reviewStoryboard.instantiateViewController(withIdentifier: "WriteReviewViewController") as! WriteReviewViewController
        let navController = UINavigationController(rootViewController: writeReviewVC)
        
        writeReviewVC.authInfo = authInfo
        writeReviewVC.show = show
        
        self.present(navController, animated:true)
    }
}
