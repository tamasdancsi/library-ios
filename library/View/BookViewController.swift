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

        //
        // TODO: update to dynamic labels
        //

        title = viewModel.title()

        yearLabel.text = viewModel.bookYearString()

        descriptionLabel.text = viewModel.descriptionsString()

        goodReadsButton.isHidden = viewModel.isGoodReadsButtonHidden()
        goodReadsButton.setTitle(NSLocalizedString("button_open_goodreads", comment: ""), for: .normal)

        openLibraryButton.isHidden = viewModel.isOpenLibraryButtonHidden()
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

