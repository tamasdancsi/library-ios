import XCTest
import RxSwift
@testable import library

class ListViewModelTests: XCTestCase {

    fileprivate var viewModel: ListViewModel = ListViewModel()
    fileprivate let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        viewModel = ListViewModel()
    }

    func testIsLoadingGetsSet() {
        var result: [Bool] = []

        // Bind isLoading
        viewModel.isLoading.asObservable()
            .subscribe(onNext: { next in
                result.append(next)
            })
            .disposed(by: disposeBag)

        // Assert
        XCTAssertEqual(result, [true], "Starting search should start isLoading flag")
    }
}
