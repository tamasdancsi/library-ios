import XCTest
import RxSwift
@testable import library

class BookViewModelTests: XCTestCase {

    fileprivate var viewModel: BookViewModel!
    fileprivate let disposeBag = DisposeBag()
    fileprivate let book1 = OpenLibraryBook(
        title: "book1Title",
        subtitle: "book1Subtitle",
        authorName: ["book1Author"],
        firstPublishYear: 2000,
        publisher: ["book1Publisher"],
        key: "book1Key",
        coverI: 1,
        idGoodreads: ["book1GoodreadsId"]
    )

    override func setUp() {
        super.setUp()
        viewModel = BookViewModel()
    }

    func testUpdatingBookTitle() {
        viewModel.updateBook(book1)
        viewModel.title.bind(onNext: { [weak self] title in
            XCTAssertEqual(title, self?.book1.title, "Title should be updated properly")
        }).disposed(by: disposeBag)
    }

    func testUpdatingBookPublishYear() {
        viewModel.updateBook(book1)
        viewModel.year
            .bind(onNext: { [weak self] year in
                guard let book1Year = self?.book1.firstPublishYear else {
                    return
                }
                XCTAssertEqual(year, "\(book1Year)", "Publish year should be updated properly")
            })
            .disposed(by: disposeBag)
    }

}
