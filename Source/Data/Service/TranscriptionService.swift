//
//  TranscriptionService.swift
//  ASRApplication
//

import Foundation
import RxSwift

class TranscriptionService: AppService {
    var transcriptionRepository: TranscriptionRepository { return RepositoryFactory.transcriptionRepository }
    
    func getTranscription() -> Observable<TranscriptionDto> {
        var options: [String: Any] = [:]
        options["part"] = "snippet"
        options["key"] = "AIzaSyCFUvUGHULmz54qKdBrfqbA9EQUVW62mrQ"
        options["q"] = "Mixi"
        return transcriptionRepository.getTranscription(options: options)
    }
}
