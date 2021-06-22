//
//  VideoStatistic.swift
//  YoutubeClone
//
//  Created by Đức Tân Nguyễn on 15/06/2021.
//

import Foundation
import SwiftyJSON

class VideoStatistic : NSObject, NSCoding{

    var viewCount : Int = 0
    var likeCount : Int = 0
    var dislikeCount: Int = 0
    var favoriteCount: Int = 0
    var commentCount: Int = 0

    init(fromJson json: JSON!) {
        if json == JSON.null{
            return
        }
        let viewCountString = json["viewCount"].stringValue
        if !viewCountString.isEmpty {
            viewCount = Int(viewCountString) ?? 0
        }
        let likeCountString = json["likeCount"].stringValue
        if !likeCountString.isEmpty {
            likeCount = Int(likeCountString) ?? 0
        }
        let dislikeCountString = json["dislikeCount"].stringValue
        if !dislikeCountString.isEmpty {
            dislikeCount = Int(dislikeCountString) ?? 0
        }
        let favoriteCountString = json["favoriteCount"].stringValue
        if !favoriteCountString.isEmpty {
            favoriteCount = Int(favoriteCountString) ?? 0
        }
        let commentCountString = json["commentCount"].stringValue
        if !commentCountString.isEmpty {
            commentCount = Int(commentCountString) ?? 0
        }
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        viewCount = aDecoder.decodeObject(forKey: "viewCount") as? Int ?? 0
        likeCount = aDecoder.decodeObject(forKey: "likeCount") as? Int ?? 0
        dislikeCount = aDecoder.decodeObject(forKey: "dislikeCount") as? Int ?? 0
        favoriteCount = aDecoder.decodeObject(forKey: "favoriteCount") as? Int ?? 0
        commentCount = aDecoder.decodeObject(forKey: "commentCount") as? Int ?? 0
    }

    @objc func encode(with aCoder:  NSCoder) {
        aCoder.encode(viewCount, forKey: "viewCount")
        aCoder.encode(likeCount, forKey: "likeCount")
        aCoder.encode(dislikeCount, forKey: "dislikeCount")
        aCoder.encode(favoriteCount, forKey: "favoriteCount")
        aCoder.encode(commentCount, forKey: "commentCount")
    }
}
