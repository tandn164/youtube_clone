//ListDto.swift

import Foundation

class ListDto<T> {
    var data: [T]!
    var pagination: Pagination!
    var total : Int!
    
    var kind: String!
    var etag: String!
    var pageInfo: Pagination!
    var nextPageToken: String!
    var prevPageToken: String!
    
    init() {
        
    }
    
    init(data: [T], pagination: Pagination!) {
        self.data = data
        self.pagination = pagination
    }
    
    init(data: [T], total: Int!) {
        self.data = data
        self.total = total
    }
}
