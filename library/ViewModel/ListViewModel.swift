
import RxSwift
import RxCocoa

class ListViewModel {

    private let openLibraryService = OpenLibraryService()
    private var books: [OpenLibraryResult]?

    let query = Variable("")

    lazy var data: Driver<[OpenLibraryBook]> = {
        return self.query.asObservable()
            .throttle(Constants.Delay.ListSearch, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(openLibraryService.search)
            .asDriver(onErrorJustReturn: [])
    }()
}
