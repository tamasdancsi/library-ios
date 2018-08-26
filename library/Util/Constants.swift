
struct Constants {

    struct NibFile {
        static let ListViewController = "ListViewController"
        static let BookViewController = "BookViewController"
        static let BookListViewCell = "BookListViewCell"
    }

    struct CellIdentifier {
        static let BookListView = "BookListViewCell"
    }

    struct ApiEndpoint {
        static let SearchBooks = "http://openlibrary.org/search.json?q=%@"
    }

    struct URL {
        static let GoodReads = "https://www.goodreads.com/book/show/%@"
        static let OpenLibrary = "https://openlibrary.org/%@"
    }

    struct Delay {
        static let ListSearch = 1.0
    }
}
