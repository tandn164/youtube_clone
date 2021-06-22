//
//  VideoIDType.swift
//  YoutubeClone
//
//  Created by Đức Tân Nguyễn on 15/06/2021.
//

import SwiftyJSON
import Foundation

class VideoIDType : NSObject, NSCoding{

    var kind : String!
    var videoId : String!

    init(fromJson json: JSON!) {
        if json == JSON.null{
            return
        }
        kind = json["kind"].stringValue
        videoId = json["videoId"].stringValue
    }

    func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        if kind != nil{
            dictionary["kind"] = kind
        }
        if videoId != nil{
            dictionary["videoId"] = videoId
        }
        return dictionary
    }

    @objc required init(coder aDecoder: NSCoder) {
        kind = aDecoder.decodeObject(forKey: "kind") as? String
        videoId = aDecoder.decodeObject(forKey: "videoId") as? String
    }

    @objc func encode(with aCoder:  NSCoder) {
        if kind != nil{
            aCoder.encode(kind, forKey: "kind")
        }
        if videoId != nil{
            aCoder.encode(videoId, forKey: "videoId")
        }
    }

}
