//
//  RepositoryDetailsView.swift
//  SuiTask
//
//  Created by Evgeny Protopopov on 20.03.2022.
//

import SwiftUI

struct RepositoryDetailsView: View {
    
    @ObservedObject var viewModel: ReposiroryDetailsViewModel
    
    let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
        self.viewModel = ReposiroryDetailsViewModel(repository: repository)
    }
    
    var body: some View {
        List(viewModel.branches, id: \.self) { branch in
            Text(branch)
        }
        .navigationTitle(repository.name ?? "")
        .onAppear(perform: {
            viewModel.loadBranches(login: repository.owner?.login ?? "", name: repository.name ?? "")
        })
    }
}

