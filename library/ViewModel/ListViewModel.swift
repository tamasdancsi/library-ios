
import RxSwift
import RxCocoa

class ListViewModel {

    // Reference to open library service
    fileprivate let openLibraryService = OpenLibraryService()

    // Variable to hold query string
    var queryVariable = BehaviorRelay(value: "")

    // Is loading flag to manage loading state
    fileprivate let isLoadingVariable = BehaviorRelay(value: false)
    var isLoading: Observable<Bool> { return isLoadingVariable.asObservable() }

    // Update data whenever query string changes
    lazy var data: Driver<[OpenLibraryBook]> = {
        return self.queryVariable.asObservable()
            .throttle(Constants.Delay.ListSearch, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { [unowned self] _ in self.isLoadingVariable.accept(true)  })
            .flatMapLatest(openLibraryService.search)
            .startWith([])
            .asDriver(onErrorJustReturn: [])
            .do(onNext: { [unowned self] _ in self.isLoadingVariable.accept(false) })
    }()

    func openBook(book: OpenLibraryBook) {
        Router.shared.pushBookViewController(book: book)
    }
}
