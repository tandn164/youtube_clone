//
//  TrendingService.swift
//  YoutubeClone
//
//  Created by Đức Tân Nguyễn on 15/06/2021.
//

import Foundation
import RxSwift

class TrendingService: AppListService<VideoSnippetDto> {
    let trendingRepository = RepositoryFactory.trendingRepository
    
    func getListTrending(limit: Int,
                         pageToken: String? = nil) -> Observable<ListDto<VideoSnippetDto>> {
        var options: [String: Any] = [:]
        options["part"] = "snippet,contentDetails,statistics"
        options["key"] = "AIzaSyCFUvUGHULmz54qKdBrfqbA9EQUVW62mrQ"
        options["chart"] = "mostPopular"
        options["maxResults"] = limit
        options["regionCode"] = "VN"
        if let pageToken = pageToken {
            options["pageToken"] = pageToken
        }
        return trendingRepository.getList(count: limit, options: options)
    }
}
