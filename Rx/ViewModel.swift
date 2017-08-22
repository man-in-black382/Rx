//
//  ViewModel.swift
//  Rx
//
//  Created by Pavlo Muratov on 18.08.17.
//  Copyright © 2017 MPO. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import Moya_ModelMapper
import RxOptional

class ViewModel {
    
    let provider: RxMoyaProvider<GitHub>
    let repositoryName: Observable<String>
    
    func trackIssues() -> Observable<[Issue]> {
        return repositoryName
            .observeOn(MainScheduler.instance)
            .flatMapLatest { name -> Observable<Repository?> in
                return self.findRepository(name: name)
            }
            .flatMapLatest { repository -> Observable<[Issue]?> in
                guard let repository = repository else { return Observable.just(nil) }
                return self.findIssues(repository: repository)
            }.replaceNilWith([])
        
    }
    
    private func findIssues(repository: Repository) -> Observable<[Issue]?> {
        return provider
        .request(GitHub.issues(repositoryFullName: repository.fullName))
        .debug()
        .mapArrayOptional(type: Issue.self)
    }
    
    private func findRepository(name: String) -> Observable<Repository?> {
        return provider
        .request(GitHub.repo(fullName: name))
        .debug()
        .mapObjectOptional(type: Repository.self)
    }
    
}
