import UIKit
import RxSwift

class BookViewController: UIViewController {

    private var viewModel: BookViewModel!
    private let disposeBag = DisposeBag()

    init(book: OpenLibraryBook) {
        super.init(nibName: Constants.NibFile.BookViewController, bundle: nil)
        viewModel = BookViewModel(book)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("[BookViewController] error: wrong init method was used")
    }
}

// MARK: - Setting up the UI
extension BookViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
