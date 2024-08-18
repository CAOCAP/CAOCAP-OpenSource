//
//  CAOCAPTests.swift
//  CAOCAPTests
//
//  Created by Azzam AL-Rashed on 26/12/2023.
//

import XCTest
@testable import CAOCAP

final class CAOCAPTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParseJS() throws {
        if let code = JavaScriptParser.shared.parseJS(code: "let xo = 10; let yo = 5; let zo = xo + yo") {
            print(code["body"])
        }
    }
    
    func testGenerateJSCode() throws {
        if let code = JavaScriptParser.shared.generateJSCode(from: ["":""]) {
            print(code)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
