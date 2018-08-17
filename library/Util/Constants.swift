
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

    struct Delay {
        static let ListSearch = 1.0
    }
}
