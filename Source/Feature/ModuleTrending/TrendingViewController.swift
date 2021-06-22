//
//  TrendingViewController.swift
//  ASRApplication
//
//  Created by Đức Tân Nguyễn on 07/06/2021.
//

import UIKit

class TrendingViewController: AppViewController {

    @IBOutlet weak var tableView: TrendingTableView!
    public var controller: TrendingController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = ControllerFactory.createController(type: TrendingController.self, for: self)
        setTitleHeader(title: "Trending")
        addView(tableView)
        tableView.controller = controller
        tableView.trendingController = controller
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tableView.reloadData()
    }
}
