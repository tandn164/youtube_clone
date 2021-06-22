//
//  TrendingController.swift
//  YoutubeClone
//
//  Created by Đức Tân Nguyễn on 15/06/2021.
//

import UIKit
import RxSwift

class TrendingController: AppListController<VideoSnippetDto> {
    
    override var stopLoadingAnimationCommand: Command { return .vStopLoadingTrending }
    override var startLoadingAnimationCommand: Command { return .vStartLoadingTrending }
    override var updateListCommand: Command { return .vUpdateListTrending }
    override var addItemsCommand: Command { return .vAddItemsToListTrending }
    
    override func getListObservable(count: Int) -> Observable<ListDto<VideoSnippetDto>> {
        return ServiceFactory.trendingServide.getListTrending(limit: count)
    }
    
    override func getNextListObservable(pageToken: String, count: Int) -> Observable<ListDto<VideoSnippetDto>> {
        return ServiceFactory.trendingServide.getListTrending(limit: count, pageToken: pageToken)
    }
}

