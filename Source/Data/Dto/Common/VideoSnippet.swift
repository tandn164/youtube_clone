//
//  VideoSnippet.swift
//  YoutubeClone
//
//  Created by Đức Tân Nguyễn on 15/06/2021.
//

import SwiftyJSON
import Foundation

class Thumbnail: NSObject, NSCoding {
    var url : String = ""
    var width: Int = 0
    var height: Int = 0
    
    init(fromJson json: JSON!) {
        if json == JSON.null {
            return
        }
        url = json["url"].stringValue
        width = json["width"].intValue
        height = json["height"].intValue
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        url = aDecoder.decodeObject(forKey: "url") as? String ?? ""
        width = aDecoder.decodeObject(forKey: "width") as? Int ?? 0
        height = aDecoder.decodeObject(forKey: "height") as? Int ?? 0
    }

    @objc func encode(with aCoder:  NSCoder) {
        aCoder.encode(url, forKey: "url")
        aCoder.encode(width, forKey: "width")
        aCoder.encode(height, forKey: "height")
    }
}

class ListThumbnail: NSObject, NSCoding {
    var defaultSize: Thumbnail!
    var mediumSize: Thumbnail!
    var highSize: Thumbnail!
    var standardSize: Thumbnail!
    var maxresSize: Thumbnail!
    
    init(fromJson json: JSON!) {
        if json == JSON.null {
            return
        }
        defaultSize = Thumbnail(fromJson: json["default"])
        mediumSize = Thumbnail(fromJson: json["medium"])
        highSize = Thumbnail(fromJson: json["high"])
        standardSize = Thumbnail(fromJson: json["standard"])
        maxresSize = Thumbnail(fromJson: json["maxres"])
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        defaultSize = aDecoder.decodeObject(forKey: "defaultSize") as? Thumbnail
        mediumSize = aDecoder.decodeObject(forKey: "mediumSize") as? Thumbnail
        highSize = aDecoder.decodeObject(forKey: "highSize") as? Thumbnail
        standardSize = aDecoder.decodeObject(forKey: "standardSize") as? Thumbnail
        maxresSize = aDecoder.decodeObject(forKey: "maxresSize") as? Thumbnail
    }

    @objc func encode(with aCoder:  NSCoder) {
        aCoder.encode(defaultSize, forKey: "defaultSize")
        aCoder.encode(mediumSize, forKey: "mediumSize")
        aCoder.encode(highSize, forKey: "highSize")
        aCoder.encode(standardSize, forKey: "standardSize")
        aCoder.encode(maxresSize, forKey: "maxresSize")
    }
}

class VideoSnippet : NSObject, NSCoding{

    var publishedAt : String = ""
    var channelId : String = ""
    var title: String = ""
    var videoDescription: String = ""
    var thumbnails: ListThumbnail!
    var channelTitle: String = ""
    var liveBroadcastContent: String = ""
    var publishTime: String = ""
    var categoryId: String = ""

    init(fromJson json: JSON!) {
        if json == JSON.null{
            return
        }
        publishedAt = json["publishedAt"].stringValue
        channelId = json["channelId"].stringValue
        title = json["title"].stringValue
        videoDescription = json["description"].stringValue
        thumbnails = ListThumbnail(fromJson: json["thumbnails"])
        channelTitle = json["channelTitle"].stringValue
        liveBroadcastContent = json["liveBroadcastContent"].stringValue
        publishTime = json["lishTime"].stringValue
        categoryId = json["categoryId"].stringValue
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        publishedAt = aDecoder.decodeObject(forKey: "publishedAt") as? String ?? ""
        channelId = aDecoder.decodeObject(forKey: "channelId") as? String ?? ""
        title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
        videoDescription = aDecoder.decodeObject(forKey: "videoDescription") as? String ?? ""
        thumbnails = aDecoder.decodeObject(forKey: "thumbnails") as? ListThumbnail
        channelTitle = aDecoder.decodeObject(forKey: "channelTitle") as? String ?? ""
        liveBroadcastContent = aDecoder.decodeObject(forKey: "liveBroadcastContent") as? String ?? ""
        publishTime = aDecoder.decodeObject(forKey: "publishTime") as? String ?? ""
        categoryId = aDecoder.decodeObject(forKey: "categoryId") as? String ?? ""
    }

    @objc func encode(with aCoder:  NSCoder) {
        aCoder.encode(publishedAt, forKey: "publishedAt")
        aCoder.encode(channelId, forKey: "channelId")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(videoDescription, forKey: "videoDescription")
        aCoder.encode(thumbnails, forKey: "thumbnails")
        aCoder.encode(channelTitle, forKey: "channelTitle")
        aCoder.encode(liveBroadcastContent, forKey: "liveBroadcastContent")
        aCoder.encode(publishTime, forKey: "publishTime")
        aCoder.encode(categoryId, forKey: "categoryId")
    }
}
