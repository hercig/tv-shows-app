//
//  ShowDetailsViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 29.07.2021..
//

import UIKit

class ShowDetailsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var showID: Int?
    var authInfo: AuthInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
