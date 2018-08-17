
import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBar: UISearchBar { return searchController.searchBar }

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
    }

    private func initBindings() {
        viewModel.data
            .drive(tableView.rx.items(cellIdentifier: Constants.CellIdentifier.BookListView, cellType: BookListViewCell.self)) { _, book, cell in
                cell.bookTitleLabel.text = book.title
                cell.authorLabel.text = book.authorName?[0]
                cell.publishYearLabel.text = (book.firstPublishYear != nil) ? String(book.firstPublishYear!) : ""
            }
            .disposed(by: disposeBag)

        searchBar.rx.text.orEmpty
            .bind(to: viewModel.query)
            .disposed(by: disposeBag)

        viewModel.data.asDriver()
            .map { String(format: NSLocalizedString("title_n_results", comment: ""), $0.count) }
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
}
