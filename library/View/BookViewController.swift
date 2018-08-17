import UIKit

class BookViewController: UIViewController {

    init() {
        super.init(nibName: Constants.NibFile.BookViewController, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: Constants.NibFile.BookViewController, bundle: nil)
    }
}

// MARK: - Setting up the UI
extension BookViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
