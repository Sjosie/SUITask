//
//  Owner.swift
//  SuiTask
//
//  Created by Evgeny Protopopov on 20.03.2022.
//

import Foundation

struct Owner: Codable {
    
    let id: Double?
    let login: String?
    let url: String?
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case url
        case avatarUrl = "avatar_url"
    }
    
    static let example = Owner(id: 484656,
                               login: "vsouza",
                               url: "https://api.github.com/users/vsouza",
                               avatarUrl: "https://avatars2.githubusercontent.com/u/484656?v=4")
    
}
