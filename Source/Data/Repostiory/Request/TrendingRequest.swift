//
//  File.swift
//  YoutubeClone
//
//  Created by Đức Tân Nguyễn on 15/06/2021.
//

import Foundation
import RxSwift

class TrendingRequest: AppRequest<VideoSnippetDto> {
    
    var expandUrl: String = "videos"
    
    override func getList(count: Int, options: [String : Any], url: String? = nil) -> Observable<HttpResponse> {
        let url = "\(AppConfig.server)\(expandUrl)"
        return super.getList(count: count, options: options, url: url)
    }
}
