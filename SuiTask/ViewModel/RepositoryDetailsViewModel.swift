//
//  RepositoryDetailsViewModel.swift
//  SuiTask
//
//  Created by Evgeny Protopopov on 21.03.2022.
//

import Foundation
import Combine

class ReposiroryDetailsViewModel: ObservableObject {
    
    @Published var branches = [String]()
    
    var subsciptions = Set<AnyCancellable>()
    private var repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
}

extension ReposiroryDetailsViewModel {
    
    func loadBranches(login: String, name: String) {
        RepositoryAPI.requestBranches(login: login, name: name)
            .mapError({ (error) -> Error in
                return error
            }).sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("failure \(error)")
                }
            }, receiveValue: {
                $0.forEach { branch in
                    self.branches.append(branch.name ?? "")
                }
            }).store(in: &subsciptions)

    }
    
}
