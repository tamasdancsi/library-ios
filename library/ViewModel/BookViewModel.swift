import Foundation

class BookViewModel {

    //
    // Properties
    //

    fileprivate let book: OpenLibraryBook!

    //
    // Initialization
    //

    init(_ book: OpenLibraryBook) {
        self.book = book
    }

    //
    // UI helpers
    //

    func title() -> String? {
        return book.title
    }

    func bookYearString() -> String {
        guard let year = book.firstPublishYear else {
            return ""
        }
        return "\(year)"
    }

    func descriptionsString() -> String {
        return "Todo: description"
    }

    func isGoodReadsButtonHidden() -> Bool {
        return book.idGoodreads == nil || (book.idGoodreads?.count)! == 0
    }

    func isOpenLibraryButtonHidden() -> Bool {
        return book.key == nil
    }

    //
    // Event handlers
    //

    func openOnGoodReads() {
        Linker.shared.openOnGoodReads(goodReadsId: book.idGoodreads?[0])
    }

    func openOnOpenLibrary() {
        Linker.shared.openOnOpenLibrary(openLibraryId: book.key)
    }
}
