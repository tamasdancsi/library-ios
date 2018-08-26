import Foundation
import UIKit

final class Linker {

    static let shared = Linker()
}

// MARK: - Good reads
extension Linker {

    func openOnGoodReads(goodReadsId: String?) {
        guard let id = goodReadsId else {
            print("[Linker] warning: empty good reads id")
            return
        }
        openLink(url: "https://www.goodreads.com/book/show/\(id)")
    }
}

// MARK: - Open library reads
extension Linker {

    func openOnOpenLibrary(openLibraryId: String?) {
        guard let id = openLibraryId else {
            print("[Linker] warning: empty open library reads id")
            return
        }
        openLink(url: "https://openlibrary.org/\(id)")
    }
}

// MARK: - Helpers
extension Linker {

    func openLink(url: String?) {
        guard let urlString = url else {
            print("[Linker] warning: empty url string")
            return
        }
        UIApplication.shared.open(URL(string: urlString)!)
    }
}
