//
//  ContentView.swift
//  SuiTask
//
//  Created by Evgeny Protopopov on 19.03.2022.
//

import SwiftUI

struct RepositoryView: View {
    
    @ObservedObject var viewModel = RepositoryViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchField(text: $viewModel.searchText)
                if viewModel.isLoading == false {
                    List(Array(viewModel.repositories.prefix(10).enumerated()), id: \.offset) { index, item in
                        NavigationLink(destination: RepositoryDetailsView(repository: item)) {
                            RepositoryCell(repository: item, repositoryCount: viewModel.repositoriesCount[index])
                        }
                    }
                } else {
                    Text("Please input some text ...")
                    Spacer()
                }
                
            }
            .navigationBarTitle("Github Repositories", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView()
    }
}
