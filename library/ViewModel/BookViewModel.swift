import Foundation
import RxSwift
import RxCocoa

class BookViewModel {

    //
    // Properties
    //
    fileprivate var book: OpenLibraryBook!

    fileprivate let titleVariable: BehaviorRelay<String> = BehaviorRelay(value: "")
    var title: Observable<String> { return titleVariable.asObservable() }

    fileprivate let yearVariable: BehaviorRelay<String> = BehaviorRelay(value: "")
    var year: Observable<String> { return yearVariable.asObservable() }

    fileprivate let authorVariable: BehaviorRelay<String> = BehaviorRelay(value: "")
    var author: Observable<String> { return authorVariable.asObservable() }

    fileprivate let coverImageVariable: BehaviorRelay<String> = BehaviorRelay(value: "")
    var coverImage: Observable<String> { return coverImageVariable.asObservable() }

    fileprivate let goodReadsIdVariable: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    var goodReadsId: Observable<String?> { return goodReadsIdVariable.asObservable() }

    fileprivate let openLibraryIdVariable: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    var openLibraryId: Observable<String?> { return openLibraryIdVariable.asObservable() }

    fileprivate let isOpenLibraryButtonHiddenVariable: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    var isOpenLibraryButtonHidden: Observable<Bool> { return isOpenLibraryButtonHiddenVariable.asObservable() }

    fileprivate let isGoodReadsButtonHiddenVariable: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    var isGoodReadsButtonHidden: Observable<Bool> { return isGoodReadsButtonHiddenVariable.asObservable() }

    //
    // Initialization and book updating
    //

    init(_ book: OpenLibraryBook) {
        updateBook(book)
    }

    func updateBook(_ book: OpenLibraryBook) {
        self.book = book

        if let title = book.title {
            titleVariable.accept(title)
        }

        if let year = book.firstPublishYear {
            yearVariable.accept("\(year)")
        }

        if let author = book.authorName {
            authorVariable.accept("\(author[0])")
        }

        if let coverImageId = book.coverI {
            coverImageVariable.accept(String(format: Constants.URL.CoverImage, coverImageId))
        }

        let grId = book.idGoodreads?[0]
        goodReadsIdVariable.accept(grId)
        isGoodReadsButtonHiddenVariable.accept(grId == nil)

        let olId = book.key
        openLibraryIdVariable.accept(olId)
        isOpenLibraryButtonHiddenVariable.accept(olId == nil)
    }

    //
    // Event handlers
    //

    func openOnGoodReads() {
        Linker.shared.openOnGoodReads(goodReadsId: goodReadsIdVariable.value)
    }

    func openOnOpenLibrary() {
        Linker.shared.openOnOpenLibrary(openLibraryId: openLibraryIdVariable.value)
    }
}

