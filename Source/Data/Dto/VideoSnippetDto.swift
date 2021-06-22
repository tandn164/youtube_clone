//
//  VideoSnippetDto.swift
//  YoutubeClone
//
//  Created by Đức Tân Nguyễn on 15/06/2021.
//

import SwiftyJSON
import Foundation

class VideoSnippetDto: BaseDto {
    var kind: String!
    var etag: String!
    var videoId: VideoIDType!
    var snippet: VideoSnippet!
    var statistics: VideoStatistic!
    
    init (kind: String,
          etag: String,
          videoId: VideoIDType,
          snippet: VideoSnippet,
          statistics: VideoStatistic!) {
        self.kind = kind
        self.etag = etag
        self.videoId = videoId
        self.snippet = snippet
        self.statistics = statistics
        super.init()
    }
    
    required init(fromJson json: JSON!){
        kind = json["kind"].stringValue
        etag = json["etag"].stringValue
        videoId = VideoIDType(fromJson: json["videoId"])
        snippet = VideoSnippet(fromJson: json["snippet"])
        statistics = VideoStatistic(fromJson: json["statistics"])
        super.init(fromJson: json)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
