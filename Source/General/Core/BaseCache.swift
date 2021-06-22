//
//  BaseCache.swift
//

import Foundation
import RxSwift
import SwiftyJSON

open class BaseCache<T: BaseEntity>: Cache {

    var settingCacheSingleEntity = true
    var storage: BaseStorage<T>!
    var liveTime: Int64 = 1000 * 60 * 15 // 15 minutes
    
    init(storage: BaseStorage<T>) {
        self.storage = storage
    }
    
    private func fail() {
        fatalError("Please extend your cache from BaseListCache or BastMapCache.")
    }
    
    open func save(_ entity: T) {
        fail()
    }
    
    open func remove(_ id: DataIdType) -> Bool {
        fail()
        return false
    }
    
    open func remove(options: [String: Any]) -> [T] {
        fail()
        return []
    }
    
    open func get(_ id: DataIdType) -> T? {
        fail()
        return nil
    }
    
    func getList(count: Int, options: [String: Any] = [:]) -> [T] {
        fail()
        return []
    }
    
    func getNextList(pivot: T, count: Int, options: [String: Any] = [:]) -> [T] {
        fail()
        return[]
    }
    
    func getAll(options: [String: Any] = [:]) -> [T] {
        fail()
        return[]
    }
    
    open func clear() {
        fail()
    }
    
    func updateValidTime(_ entity: T) {
        if liveTime > 0 {
            entity.validTime = Util.currentTime() + liveTime
        } else {
            entity.validTime = Int64.max
        }
    }
    
    func save(_ json: JSON) -> AnyObject {
        let e = T(fromJson: json)
        updateValidTime(e)
        self.save(e)
        return e
    }
    
    func isCacheForEntity(name: String) -> Bool {
        return T.entityName == name || T.pluralName == name
    }
    
    open func save(_ entities: [T]) {
        for entity in entities {
            save(entity)
        }
    }
    
    open func saveAsync(_ entity: T) -> Observable<T> {
        return Observable<T>.create({subscribe in
            self.save(entity)
            subscribe.onNext(entity)
            subscribe.onCompleted()
            return Disposables.create()
        })
    }
    
    open func saveAsync(_ entities: [T]) -> Observable<[T]> {
        return Observable<[T]>.create({subscribe in
            self.save(entities)
            subscribe.onNext(entities)
            subscribe.onCompleted()
            return Disposables.create()
        })
    }
    
    open func updateAsync(_ entity: T) -> Observable<T> {
        return Observable<T>.create({subscribe in
            //TODO implement
            _ = self.save(entity)
            subscribe.onNext(entity)
            subscribe.onCompleted()
            return Disposables.create()
        })
    }
    
    open func removeAsync(_ id: DataIdType) -> Observable<Bool> {
        return Observable<Bool>.create({subscribe in
            if self.remove(id) {
                subscribe.onNext(true)
            } else {
                subscribe.onError(CacheError.unknown)
            }
            subscribe.onCompleted()
            return Disposables.create()
        })
    }
    
    open func getAsync(_ id: DataIdType) -> Observable<T> {
        return Observable<T>.create({subscribe in
            if let entity = self.get(id) {
                subscribe.onNext(entity)
            }
            subscribe.onCompleted()
            return Disposables.create()
        })
    }
    
    func getListAsync(count: Int, options: [String: Any] = [:]) -> Observable<ListDto<T>> {
        return Observable<ListDto<T>>.create({subscribe in
            var entities: [T]!
            if let pivot = options[Constant.RepositoryParam.pivot] as? T {
                entities = self.getNextList(pivot: pivot, count: count, options: options)
            } else {
                entities = self.getList(count: count, options: options)
            }
            print("Got \(entities.count) from cache")
            if entities.count >= count {
                //TODO: add pagination data
                subscribe.onNext(ListDto<T>(data: entities, pagination: nil))
            }
            subscribe.onCompleted()
            return Disposables.create()
        })
    }
    
    func getAllAsync(options: [String: Any] = [:]) -> Observable<ListDto<T>> {
        return Observable<ListDto<T>>.create({subscribe in
            let entities = self.getAll(options: options)
            if entities.count > 0 {
                //TODO: add pagination data
                subscribe.onNext(ListDto<T>(data: entities, pagination: nil))
            }
            subscribe.onCompleted()
            return Disposables.create()
        })
    }
    
    func removeAsync(options: [String: Any] = [:]) -> Observable<ListDto<T>> {
        return Observable<ListDto<T>>.create {
            subscribe in
            let entities = self.remove(options: options)
            subscribe.onNext(ListDto<T>(data: entities, pagination: nil))
            subscribe.onCompleted()
            return Disposables.create()
        }
    }
}

//TODO error
enum CacheError: Error {
    case unknown
}
