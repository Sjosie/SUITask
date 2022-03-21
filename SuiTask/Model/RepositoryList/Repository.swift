//
//  Repository.swift
//  SuiTask
//
//  Created by Evgeny Protopopov on 20.03.2022.
//

import Foundation

struct Repository: Codable, Identifiable {
    
    let id: Double?
    let name: String?
    let fullName: String?
    let owner: Owner?
    let description: String?
    let language: String?
    let forks: Double?
    let stars: Double?
    let url: String?
    let public_repos: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case description
        case language
        case forks = "forks_count"
        case stars = "stargazers_count"
        case url
        case public_repos
    }
    
    static let example = Repository(id: 21700699,
                                    name: "awesome-ios",
                                    fullName: "vsouza/awesome-ios",
                                    owner: Owner.example,
                                    description: "A curated list of awesome iOS ecosystem, including Objective-C and Swift Projects",
                                    language: "Swift",
                                    forks: 6022,
                                    stars: 36055, url: "https://api.github.com/users/Automattic", public_repos: 2)
    
}
