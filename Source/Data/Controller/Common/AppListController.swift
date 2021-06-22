//
//  AppListController.swift
//

import Foundation
import RxSwift

class AppListController<T: Serializable>: AppController, ListControllable {
    var items = [T]()
    var hasNext = false
    var itemPerPage = AppConfig.itemPerPage
    var service: AppListService<T>!
    var pagination: Pagination!
    
    var currentTask: Disposable?
    var isTaskRunning: Bool = false
    var nextPageToken: String?
    var prevPageToken: String?
    
    var stopLoadingAnimationCommand: Command { return ._vStopLoadingAnimation }
    var startLoadingAnimationCommand: Command { return ._vStartLoadingAnimation }
    var updateListCommand: Command { return ._vUpdateList }
    var addItemsCommand: Command { return ._vAddItems }
    
    init(service: AppListService<T>) {
        super.init()
        self.service = service
        validateCommands()
    }
    
    internal required init() {
        super.init()
    }
    
    private func validateCommands() {
        if stopLoadingAnimationCommand == ._vStopLoadingAnimation || startLoadingAnimationCommand == ._vStartLoadingAnimation
            || updateListCommand == ._vUpdateList || addItemsCommand == ._vAddItems {
            fatalError("All commands MUST be overridden")
        }
    }
    
    var itemCount: Int {
        get {
            return items.count
        }
    }
    
    func reset() {
        items = [T]()
        hasNext = false
    }
    
    override func onError(error: Error) {
        super.onError(error: error)
        isTaskRunning = false
    }

    override func onComplete() {
        super.onComplete()
        isTaskRunning = false
        notifyObservers(stopLoadingAnimationCommand)
    }
    
    func getList() {
        cancelCurrentTask()
        isTaskRunning = true
        notifyObservers(startLoadingAnimationCommand)
        currentTask = getListObservable(count: itemPerPage).subscribe(
            onNext: {[weak self] listDto in
                guard let this = self else { return }
                this.pagination = listDto.pagination
                this.nextPageToken = listDto.nextPageToken
                this.prevPageToken = listDto.prevPageToken
                this.items = this.transformDataOriginList(data: listDto.data)
                this.checkHasNext(listDto: listDto)
                this.notifyObservers(this.updateListCommand)
            },
            onError: onError,
            onCompleted: onComplete
        )
        currentTask?.disposed(by: disposeBag)
    }
    
    func getNextList() {
        if isTaskRunning {
            return
        }
        
        isTaskRunning = true
        if let nextPageToken = nextPageToken {
            currentTask = getNextListObservable(pageToken: nextPageToken, count: itemPerPage).subscribe(
                onNext: {[weak self] listDto in
                    guard let this = self else { return }
                    this.nextPageToken = listDto.nextPageToken
                    this.prevPageToken = listDto.prevPageToken
                    this.pagination = listDto.pagination
                    this.items = this.transformDataNextList(data: listDto.data)
                    this.checkHasNext(listDto: listDto)
                    this.notifyObservers(this.addItemsCommand)
                },
                onError: onError,
                onCompleted: onComplete
            )
            currentTask?.disposed(by: disposeBag)
        } else {
            self.getList()
        }
    }
    
    func getListObservable(count: Int) -> Observable<ListDto<T>> {
        return service.getList(count: itemPerPage)
    }
    
    func getNextListObservable(pivot: T, count: Int) -> Observable<ListDto<T>> {
        return service.getNextList(pivot: pivot, count: count)
    }

    func getNextListObservable(cursor: String, count: Int) -> Observable<ListDto<T>> {
        return service.getNextList(cursor: cursor, count: count)
    }
    
    func getNextListObservable(pageToken: String, count: Int) -> Observable<ListDto<T>> {
        return service.getNextList(pageToken: pageToken, count: count)
    }
    
    func transformDataOriginList(data: [T]) -> [T] {
        return data
    }
    
    func getPivot() -> T? {
        return items.last
    }
    
    func getOffset() -> Int? {
        return items.count
    }

    var nextCursor: String? {
        return pagination?.after
    }
    
    func transformDataNextList(data: [T]) -> [T] {
        return items + data
    }
    
    func checkHasNext(listDto: ListDto<T>) {
        self.hasNext = listDto.data.count >= self.itemPerPage
    }
    
    func cancelCurrentTask() {
        currentTask?.dispose()
    }

    func clear() {
        items.removeAll()
    }
}
