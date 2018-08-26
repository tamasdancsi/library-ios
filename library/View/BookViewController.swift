import UIKit
import RxSwift

class BookViewController: UIViewController {

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var goodReadsButton: UIButton!
    @IBOutlet weak var openLibraryButton: UIButton!

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
        initBindings()
    }

    private func initBindings() {
        // Updating view controller title
        viewModel.title.bind(onNext: { [weak self] title in
            self?.title = title
        }).disposed(by: disposeBag)

        // Updating year label
        viewModel.year
            .bind(to: yearLabel.rx.text)
            .disposed(by: disposeBag)

        // Updating description label
        viewModel.description
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)

        // Updating good reads button
        viewModel.isGoodReadsButtonHidden
            .bind(to: goodReadsButton.rx.isHidden)
            .disposed(by: disposeBag)
        goodReadsButton.setTitle(NSLocalizedString("button_open_goodreads", comment: ""), for: .normal)

        // Updating open library button
        viewModel.isOpenLibraryButtonHidden
            .bind(to: openLibraryButton.rx.isHidden)
            .disposed(by: disposeBag)
        openLibraryButton.setTitle(NSLocalizedString("button_open_openlibrary", comment: ""), for: .normal)
    }
}

// MARK: - Action handling
extension BookViewController {

    @IBAction func onGoodReadsButtonTap(_ sender: Any) {
        viewModel.openOnGoodReads()
    }

    @IBAction func onOpenLibraryButtonTap(_ sender: Any) {
        viewModel.openOnOpenLibrary()
    }
}
