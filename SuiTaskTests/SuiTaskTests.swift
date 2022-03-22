//
//  SuiTaskTests.swift
//  SuiTaskTests
//
//  Created by Evgeny Protopopov on 21.03.2022.
//

import XCTest
import Combine
@testable import SuiTask

class SuiTaskTests: XCTestCase {
    
    private var mockApiClient: MockRepositoriesClient!
    private var viewModelToTest: RepositoryViewModel!
    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockApiClient = MockRepositoriesClient()
        viewModelToTest = RepositoryViewModel()
    }
    
    override func tearDownWithError() throws {
        mockApiClient = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }
    
    func testExistingResult() {
        
        let repositoriesToTest = RepositoriesResponse(items: [Repository.example])
        let expectation = XCTestExpectation(description: "State is set to loaded")
        
        viewModelToTest.$viewState.dropFirst().sink { state in
            // because that's not enought for displaying data (enought is having the same repos count for the results)
            XCTAssertEqual(state, .loadedRepos)
            expectation.fulfill()
        }.store(in: &cancellables)

        mockApiClient.fetchReposResults = Result.success(repositoriesToTest).publisher.eraseToAnyPublisher()
        viewModelToTest.getRepositories("q")

        wait(for: [expectation], timeout: 5)
        
    }
    
    func testEmptyResult() {
        
        let repositoriesToTest = RepositoriesResponse(items: [])
        let expectation = XCTestExpectation(description: "State is set to empty")
        
        viewModelToTest.$viewState.dropFirst().sink { state in
            XCTAssertEqual(state, .empty)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        mockApiClient.fetchReposResults = Result.success(repositoriesToTest).publisher.eraseToAnyPublisher()
        viewModelToTest.getRepositories("")
        
        wait(for: [expectation], timeout: 1)
        
    }
    
}

class MockRepositoriesClient {
    
    var fetchReposResults: AnyPublisher<RepositoriesResponse, Error>!
    
    func requestRepos(_ q: String) -> AnyPublisher<RepositoriesResponse, Error> {
        return fetchReposResults
    }
}
