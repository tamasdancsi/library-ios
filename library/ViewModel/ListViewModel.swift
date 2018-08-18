
import RxSwift
import RxCocoa

class ListViewModel {

    private let openLibraryService = OpenLibraryService()

    let query = Variable("")
    let isLoading = BehaviorSubject(value: false)

    lazy var data: Driver<[OpenLibraryBook]> = {
        return self.query.asObservable()
            .throttle(Constants.Delay.ListSearch, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { [unowned self] _ in self.isLoading.onNext(true) })
            .flatMapLatest(openLibraryService.search)
            .asDriver(onErrorJustReturn: [])
            .do(onNext: { [unowned self] _ in self.isLoading.onNext(false) })
    }()
}
