//
//  ListResponse.swift
//

import Foundation
import SwiftyJSON

class ListResponse<T: Serializable> {
    var kind: String!
    var etag: String!
    var data: [T]!
    var pageInfo: Pagination!
    var nextPageToken: String!
    var prevPageToken: String!
    
    init(fromJson json: JSON!){
        if json == JSON.null{
            return
        }
        
        data = [T]()
        let itemsArray = json["items"].arrayValue
        for itemJson in itemsArray{
            let value = T(fromJson: itemJson)
            data.append(value)
        }
        pageInfo = Pagination(fromJson: json["pageInfo"])
        kind = json["kind"].stringValue
        etag = json["etag"].stringValue
        nextPageToken = json["nextPageToken"].stringValue
        prevPageToken = json["prevPageToken"].stringValue
    }
}
