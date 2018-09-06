import UIKit
import RxSwift
import SDWebImage

class BookViewController: UIViewController, TappableDelegate {

    @IBOutlet weak var yearLabel: InfoLabel!
    @IBOutlet weak var authorLabel: InfoLabel!
    @IBOutlet weak var goodReadsButton: Tappable!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var openLibraryButton: Tappable!

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
        viewModel.title
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak self] title in
                self?.title = title
            }).disposed(by: disposeBag)

        // Updating year label
        viewModel.year
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak self] year in
                self?.yearLabel.set(title: year, label: NSLocalizedString("label_published_in", comment: ""))
            })
            .disposed(by: disposeBag)

        // Updating author label
        viewModel.author
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak self] author in
                self?.authorLabel.set(title: author, label: NSLocalizedString("label_author", comment: ""))
            })
            .disposed(by: disposeBag)

        // Updating cover image
        viewModel.coverImage
            .observeOn(MainScheduler.instance)
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
            .observeOn(MainScheduler.instance)
            .bind(to: goodReadsButton.rx.isHidden)
            .disposed(by: disposeBag)
        goodReadsButton.set(title: NSLocalizedString("button_open_goodreads", comment: ""), label: nil)
        goodReadsButton.delegate = self

        // Updating open library button
        viewModel.isOpenLibraryButtonHidden
            .observeOn(MainScheduler.instance)
            .bind(to: openLibraryButton.rx.isHidden)
            .disposed(by: disposeBag)
        openLibraryButton.set(title: NSLocalizedString("button_open_openlibrary", comment: ""), label: nil)
        openLibraryButton.delegate = self
    }
}

// MARK: - Action handling
extension BookViewController {

    func onTappableTap(_ sender: Tappable) {
        if sender == openLibraryButton {
            viewModel.openOnOpenLibrary()
        } else {
            viewModel.openOnGoodReads()
        }
    }
}
