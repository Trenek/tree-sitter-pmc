import XCTest
import SwiftTreeSitter
import TreeSitterPmc

final class TreeSitterPmcTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_pmc())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Przykladowa Maszyna Cyfrowa grammar")
    }
}
