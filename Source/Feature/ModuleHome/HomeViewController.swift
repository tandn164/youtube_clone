//
//  HomeViewController.swift
//  ASRApplication
//
//  Created by Đức Tân Nguyễn on 07/06/2021.
//

import UIKit

class HomeViewController: AppViewController {
    var transcriptController: TranscriptionController?
    @IBOutlet weak var tableView: HomeTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        transcriptController = ControllerFactory.createController(type: TranscriptionController.self, for: self)
        transcriptController?.getTranscription()
        addView(tableView)
        setTitleHeader(title: "Discover")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func update(_ command: Command, data: Any?) {
        switch command {
        case .vPlayVideo:
            let vc = PlayVideoViewController()
            navigationController?.pushViewController(vc, animated: false)
//            print("Playvideo")
        default:
            super.update(command, data: data)
        }
    }
}
