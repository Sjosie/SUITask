//
//  RepositoryCell.swift
//  SuiTask
//
//  Created by Evgeny Protopopov on 20.03.2022.
//

import SwiftUI

struct RepositoryCell: View {
    
    let repository: Repository?
    let repositoryCount: Int?
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            HStack {
                Image(systemName: "arrow.branch")
                Text("Name: \(repository?.name ?? "")")
            }
            HStack {
                Image(systemName: "person.fill")
                Text("Owner: \(repository?.owner?.login ?? "")")
            }
            HStack {
                Image(systemName: "tuningfork")
                Text("Forks: \(String(format: "%.0f", repository?.forks ?? ""))")
            }
            HStack {
                Image(systemName: "folder.circle.fill")
                Text("Repositories count: \(repositoryCount ?? 0)")
            }
        }
        .padding()
    }
}

//struct RepositoryCell_Previews: PreviewProvider {
//    static let repository = Repository.example
//    static var previews: some View {
//        RepositoryCell(repository: repository, repositoryCount: 1)
//    }
//}
