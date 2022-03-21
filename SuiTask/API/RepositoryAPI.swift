//
//  RepositoryAPI.swift
//  SuiTask
//
//  Created by Evgeny Protopopov on 20.03.2022.
//

import Foundation
import Combine

enum RepositoryAPI {
    
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://api.github.com/search/repositories")!
    
}

extension RepositoryAPI {
    
    static func requestRepos(_ q: String) -> AnyPublisher<RepositoriesResponse, Error> {
        
        guard var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else {
            fatalError("Couldn't create URLComponents")
        }
        
        components.queryItems = [URLQueryItem(name: "q", value: "\(q)")]
        
        let request = URLRequest(url: components.url!)
        
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func requestReposCount(_ url: String) -> AnyPublisher<RepositoryCount, Error> {
        
        guard let components = URLComponents(url: URL(string: url)!, resolvingAgainstBaseURL: false) else {
            fatalError("Couldn't create URLComponents")
        }
        
        let request = URLRequest(url: components.url!)
        
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()

        
    }
    
    static func requestBranches(login: String, name: String) -> AnyPublisher<[Branches], Error> {
        
        let branchesUrl = URL(string: "https://api.github.com/repos/\(login)/\(name)/branches")!

        guard let components = URLComponents(url: branchesUrl, resolvingAgainstBaseURL: false) else {
            fatalError("Couldn't create URLComponents")
        }
        
        let request = URLRequest(url: components.url!)

        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()

    }
}
