
import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let searchController = UISearchController(searchResultsController: nil)

    private let viewModel = ListViewModel()
    private let disposeBag = DisposeBag()

    init() {
        super.init(nibName: Constants.NibFile.ListViewController, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: Constants.NibFile.ListViewController, bundle: nil)
    }
}

// MARK: - Setting up the UI
extension ListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("title_my_books", comment: "")
        initTableView()
        initSearchController()
        initBindings()
    }

    private func initTableView() {
        let nib = UINib(nibName: Constants.NibFile.BookListViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.CellIdentifier.BookListView)
    }

    private func initSearchController() {
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("placeholder_search", comment: "")
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }

    private func initBindings() {
        // Connecting tableview
        viewModel.data
            .drive(tableView.rx.items(cellIdentifier: Constants.CellIdentifier.BookListView, cellType: BookListViewCell.self)) { _, book, cell in
                cell.bookTitleLabel.text = book.title
                cell.authorLabel.text = book.authorName?[0]
                cell.publishYearLabel.text = (book.firstPublishYear != nil) ? String(book.firstPublishYear!) : ""
            }
            .disposed(by: disposeBag)

        // Book selection handler
        tableView.rx
            .modelSelected(OpenLibraryBook.self)
            .subscribe(onNext: { [weak self] book in
                self?.viewModel.openBook(book: book)
            })
            .disposed(by: disposeBag)

        // Connecting query string to searchbar
        searchController.searchBar.rx.text.orEmpty
            .bind(to: viewModel.queryVariable)
            .disposed(by: disposeBag)

        // Updating navigation title
        viewModel.data.asDriver()
            .map { $0.count == 0
                ? NSLocalizedString("title_my_books", comment: "")
                : String(format: NSLocalizedString("title_n_results", comment: ""), $0.count) }
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)

        // Updating loading spinner
        viewModel.isLoading.bind { (next) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = next
            }
            .disposed(by: disposeBag)
    }
}

