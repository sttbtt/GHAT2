//
//  UnitTestingViewModel_Tests.swift
//  GHAT2_Tests
//
//  Created by Scott Bennett on 5/8/23.
//

import XCTest
@testable import GHAT2

final class UnitTestingViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_UnitTestingViewModel_isPremium_shouldBeTrue() throws {
        let userIsPremium: Bool = true

        let vm = UnitTestingViewModel(isPremium: userIsPremium)

        XCTAssertTrue(vm.isPremium)

    }

    func test_UnitTestingViewModel_isPremium_shouldBeFalse() throws {
        let userIsPremium: Bool = false

        let vm = UnitTestingViewModel(isPremium: userIsPremium)

        XCTAssertFalse(vm.isPremium)

    }

}
