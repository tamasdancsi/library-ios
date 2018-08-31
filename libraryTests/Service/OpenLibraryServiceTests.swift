import XCTest
@testable import library

class OpenLibraryServiceTests: XCTestCase {

    fileprivate let openLibraryService = OpenLibraryService()

    override func setUp() {
        super.setUp()
    }

    func testParsingEmptyData() {
        let result = openLibraryService.parse(_data: nil)
        XCTAssertEqual(result, [], "Parsing empty data should return []")
    }
}
