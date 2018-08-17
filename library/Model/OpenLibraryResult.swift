
struct OpenLibraryResult: Codable {

    let start: Int
    let numFound: Int
    let docs: [OpenLibraryBook]

    private enum CodingKeys: String, CodingKey {
        case start
        case numFound = "num_found"
        case docs
    }
}

struct OpenLibraryBook: Codable {

    let title: String?
    let subtitle: String?
    let authorName: [String]?
    let firstPublishYear: Int?
    let publisher: [String]?

    /// Key identifies the result's detail page on https://openlibrary.org/<key>
    let key: String?

    /// Cover image reference. Can be used in the format of https://covers.openlibrary.org/w/id/<cover_i>.jpg or https://covers.openlibrary.org/w/id/<cover_i>-L.jpg
    let coverI: Int?

    /// Optional goodreads book id. Can be used in the format of https://www.goodreads.com/book/show/<id_goodreads>
    let idGoodreads: [String]?

    private enum CodingKeys: String, CodingKey {
        case key
        case title
        case subtitle
        case authorName = "author_name"
        case firstPublishYear = "first_publish_year"
        case coverI = "cover_i"
        case publisher
        case idGoodreads = "id_goodreads"
    }
}
