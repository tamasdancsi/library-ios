
import RxSwift
import RxCocoa

class ListViewModel {

    //
    // Dependencies and properties
    //

    fileprivate let openLibraryService = OpenLibraryService()
    fileprivate let disposeBag = DisposeBag()

    //
    // Variables and observers
    //

    var queryVariable = BehaviorRelay(value: "")

    fileprivate let isLoadingVariable = BehaviorRelay(value: false)
    var isLoading: Observable<Bool> { return isLoadingVariable.asObservable() }

    fileprivate var dataVariable: BehaviorRelay<[OpenLibraryBook]> = BehaviorRelay(value: [])
    var data: Driver<[OpenLibraryBook]> { return dataVariable.asDriver() }

    //
    // Initialization
    //

    init() {
        queryVariable.asObservable()
            .throttle(Constants.Delay.ListSearch, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { [unowned self] _ in self.isLoadingVariable.accept(true)  })
            .flatMapLatest(openLibraryService.search)
            .do(onNext: { [unowned self] _ in self.isLoadingVariable.accept(false)  })
            .bind(to: dataVariable)
            .disposed(by: disposeBag)
    }

    //
    // Event handlers
    //

    func openBook(book: OpenLibraryBook) {
        Router.shared.pushBookViewController(book: book)
    }
}
