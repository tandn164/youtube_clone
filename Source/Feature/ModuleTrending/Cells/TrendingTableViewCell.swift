//
//  TrendingTableViewCell.swift
//  YoutubeClone
//
//  Created by Đức Tân Nguyễn on 08/06/2021.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var channelThumbnail: UIImageView!
    @IBOutlet weak var channelFollowers: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    var data: VideoSnippetDto? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI() {
        if let maxres = data?.snippet.thumbnails.maxresSize,
           !maxres.url.isEmpty {
            thumbnail.setImage(with: maxres.url)
        } else if let standard = data?.snippet.thumbnails.standardSize,
                  !standard.url.isEmpty {
            thumbnail.setImage(with: standard.url)
        } else if let high = data?.snippet.thumbnails.highSize,
                  !high.url.isEmpty {
            thumbnail.setImage(with: high.url)
        } else if let medium = data?.snippet.thumbnails.mediumSize,
                  !medium.url.isEmpty {
            thumbnail.setImage(with: medium.url)
        } else {
            thumbnail.setImage(with: data?.snippet.thumbnails.defaultSize.url ?? "")
        }
        channelTitle.text = data?.snippet.channelTitle
        let viewCount = data?.statistics.viewCount ?? 0
        if viewCount > 1 {
            viewCountLabel.text = "\(viewCount) views"
        } else {
            viewCountLabel.text = "\(viewCount) view"
        }
        titleLabel.text = data?.snippet.title
    }
}
