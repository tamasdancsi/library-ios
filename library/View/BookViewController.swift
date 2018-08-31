import UIKit
import RxSwift
import SDWebImage

class BookViewController: UIViewController {

    @IBOutlet weak var yearLabel: InfoLabel!
    @IBOutlet weak var authorLabel: InfoLabel!
    @IBOutlet weak var goodReadsButton: UIButton!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
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
            .bind(onNext: { [weak self] year in
                self?.yearLabel.set(title: year, label: NSLocalizedString("label_published_in", comment: ""))
            })
            .disposed(by: disposeBag)

        // Updating author label
        viewModel.author
            .bind(onNext: { [weak self] author in
                self?.authorLabel.set(title: author, label: NSLocalizedString("label_author", comment: ""))
            })
            .disposed(by: disposeBag)

        // Updating cover image
        viewModel.coverImage
            .subscribe(
                onNext: { [weak self] imageUrl in
                    guard let url = URL(string: imageUrl) else {
                        return
                    }
                    self?.loadingIndicator.isHidden = false
                    self?.coverImageView.sd_setImage(with: url, completed: { [weak self] (image, error, imageCacheType, url) in
                        self?.loadingIndicator.isHidden = true
                    })
                }, onError: { [weak self] error in
                    self?.loadingIndicator.isHidden = true
                }, onCompleted: {[weak self] in
                    self?.loadingIndicator.isHidden = true
                }, onDisposed: {[weak self] in
                    self?.loadingIndicator.isHidden = true
            })
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
