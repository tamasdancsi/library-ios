
import RxSwift

struct OpenLibraryService {

    func search(_ query: String) -> Observable<[OpenLibraryBook]> {
        guard
            let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: String(format: Constants.ApiEndpoint.SearchBooks, escapedQuery)) else {
                return Observable.just([])
        }
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .retry(3)
            .map(parse)
            .share(replay: 1) // TODO: TEST
    }

    private func parse(_data: Data?) -> [OpenLibraryBook] {
        guard
            let data = _data else {
            return []
        }
        let decoder = JSONDecoder()
        do {
            let parsed = try decoder.decode(OpenLibraryResult.self, from: data)
            return parsed.docs
        } catch let error {
            print("[OpenLibraryService] parsing error:", error.localizedDescription)
        }
        return []
    }
}
