//
//  PlayerTableViewCell.swift
//  YoutubeClone
//
//  Created by Đức Tân Nguyễn on 09/06/2021.
//

import UIKit
import YouTubePlayer_Swift

class PlayerTableViewCell: UITableViewCell {
    @IBOutlet weak var playerView: YouTubePlayerView!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(playerView)
        playerView.playerVars = ["playsinline": 1 as AnyObject,
                                 "showinfo": 0 as AnyObject,
                                 "controls": 0 as AnyObject]
        playerView.loadVideoID("h47dWAI53pM")
    }
}
