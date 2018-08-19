
import RxSwift
import RxCocoa

class ListViewModel {

    fileprivate let openLibraryService = OpenLibraryService()

    var queryVariable = BehaviorRelay(value: "")

    fileprivate let isLoadingVariable = BehaviorRelay(value: false)
    var isLoading: Observable<Bool> { return isLoadingVariable.asObservable() }

    lazy var data: Driver<[OpenLibraryBook]> = {
        return self.queryVariable.asObservable()
            .throttle(Constants.Delay.ListSearch, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { [unowned self] _ in self.isLoadingVariable.accept(true)  })
            .flatMapLatest(openLibraryService.search)
            .asDriver(onErrorJustReturn: [])
            .do(onNext: { [unowned self] _ in self.isLoadingVariable.accept(false) })
    }()
}
