//
//  SwiftyTextTableTests.swift
//  SwiftyTextTableTests
//
//  Created by Scott Hoyt on 2/3/16.
//  Copyright © 2016 Scott Hoyt. All rights reserved.
//

import XCTest
import SwiftyTextTable

class SwiftyTextTableTests: XCTestCase {

    func fooTable() -> TextTable {
        let foo = TextTableColumn(header: "foo")
        let bar = TextTableColumn(header: "bar")
        let baz = TextTableColumn(header: "baz")
        var table = TextTable(columns: [foo, bar, baz])
        table.addRow("1", "2")
        table.addRow(11, 22, 33)
        table.addRow(111, 222, 333, 444)
        return table
    }

    func testRenderDefault() {
        let output = fooTable().render()
        let expected = "+-----+-----+-----+\n" +
                       "| foo | bar | baz |\n" +
                       "+-----+-----+-----+\n" +
                       "| 1   | 2   |     |\n" +
                       "| 11  | 22  | 33  |\n" +
                       "| 111 | 222 | 333 |\n" +
                       "+-----+-----+-----+"
        XCTAssertEqual(output, expected)
    }

    func testRenderCustom() {
        var table = fooTable()
        table.columnFence = "!"
        table.rowFence = "*"
        table.cornerFence = "."
        let output = table.render()
        let expected = ".*****.*****.*****.\n" +
                       "! foo ! bar ! baz !\n" +
                       ".*****.*****.*****.\n" +
                       "! 1   ! 2   !     !\n" +
                       "! 11  ! 22  ! 33  !\n" +
                       "! 111 ! 222 ! 333 !\n" +
                       ".*****.*****.*****."
        XCTAssertEqual(output, expected)
    }

    func testStripping() {
        let c1 = TextTableColumn(header: "\u{001B}[0mHello\u{001B}[0m")
        XCTAssertEqual(c1.width, 5)

        let c2 = TextTableColumn(header: "\u{001B}[31m\u{001B}[4;31;93mHello World\u{001B}[0m\u{001B}[0m")
        XCTAssertEqual(c2.width, 11)

        let c3 = TextTableColumn(header: "\u{001B}[0m\u{001B}[0m")
        XCTAssertEqual(c3.width, 0)

        let c4 = TextTableColumn(header: "\u{001B}[31mHello World\u{001B}[0m")
        XCTAssertEqual(c4.width, 11)

        let c5 = TextTableColumn(header: "\u{001B}[4;31;42;93;5mHello World\u{001B}[0m")
        XCTAssertEqual(c5.width, 11)

        let c6 = TextTableColumn(header: "\u{001B}[4;31;93mHello World\u{001B}[0m")
        XCTAssertEqual(c6.width, 11)

        let c7 = TextTableColumn(header: "Hello World")
        XCTAssertEqual(c7.width, 11)
    }

    // MARK: - protocol XCTestCaseProvider for SPM
    lazy var allTests: [(String, () throws -> Void)] = [
        ("testRenderDefault", self.testRenderDefault),
        ("testRenderCustom", self.testRenderCustom),
        ("testStripping", self.testRenderCustom)
    ]
}
