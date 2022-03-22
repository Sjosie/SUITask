//
//  ReposViewModel.swift
//  SuiTask
//
//  Created by Evgeny Protopopov on 19.03.2022.
//

import Foundation
import Combine

class RepositoryViewModel: ObservableObject {
    
    @Published private(set) var repositories: [Repository] = []
    @Published private(set) var repositoriesCount = [Int]()
    
    @Published var searchText = ""
    @Published var viewState: RepositoriesViewState = .empty
    
    var subsciptions = Set<AnyCancellable>()
    
    init() { setUpFetching() }
}

extension RepositoryViewModel {
    
    func setUpFetching() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.repositories.removeAll()
                    return nil
                }
                return string
            })
            .compactMap { $0 }
            .sink(receiveValue: { [self] (searchText) in
                getRepositories(searchText)
            }).store(in: &subsciptions)
    }
    
    func getRepositories(_ searchText: String) {
        RepositoryAPI.requestRepos(searchText)
            .mapError({ (error) -> Error in
                return error
            }).sink(receiveCompletion: { result in

            }, receiveValue: {
                
                self.repositoriesCount.removeAll()
                self.repositories.removeAll()
                self.viewState = .empty
                
                self.repositories = $0.items ?? []
                
                self.repositories.prefix(10).forEach { repo in
                    self.getRepositoriesCount(repo.owner?.url ?? "")
                }
                
            }).store(in: &subsciptions)
    }
    
    func getRepositoriesCount(_ url: String) {
        RepositoryAPI.requestReposCount(url)
            .mapError({ (error ) -> Error in
                return error
            }).sink(receiveCompletion: { _ in
                
            }, receiveValue: { value in
                
                self.repositoriesCount.insert((value.public_repos ?? 0), at: 0)
                
                if self.repositoriesCount.count == self.repositories.prefix(10).count {
                    self.viewState = .populated
                }
                
            }).store(in: &subsciptions)
    }
}

enum RepositoriesViewState {
    case empty, populated
}
