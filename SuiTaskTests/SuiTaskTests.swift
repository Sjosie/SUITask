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

    func testEmpty() {
        let repositories = RepositoriesResponse(items: [])
        XCTAssertTrue(repositories.items!.isEmpty)
    }
    
}
