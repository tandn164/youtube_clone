//
//  PlayVideoViewController.swift
//  YoutubeClone
//
//  Created by Đức Tân Nguyễn on 09/06/2021.
//

import UIKit

class PlayVideoViewController: AppViewController {
    @IBOutlet weak var tableView: PlayVideoTableView!
    
//    @IBOutlet weak var playerView: YoutubePlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addView(tableView)
//        playerView.loadWithVideoId("ZMgvvnGF5Cs")
    }
}
