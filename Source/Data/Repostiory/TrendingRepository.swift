//
//  TrendingRepository.swift
//  YoutubeClone
//
//  Created by Đức Tân Nguyễn on 15/06/2021.
//

import Foundation
import RxSwift

class TrendingRepository: AppRemoteRepository<VideoSnippetDto> {
    
    var trendingRequest = RequestFactory.trendingRequest
    
    init() {
        super.init(request: RequestFactory.trendingRequest)
    }
}
