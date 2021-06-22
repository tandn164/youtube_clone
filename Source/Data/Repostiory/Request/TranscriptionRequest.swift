//
//  TranscriptionRequest.swift
//  ASRApplication
//

import RxSwift

class TranscriptionRequest: AppRequest<TranscriptionDto> {
    func getTranscription(options: [String: Any]) -> Observable<HttpResponse> {
        let url = AppConfig.server + "search"
        return createResponseObservable(method: .GET, url: url, params: options)
    }
}
