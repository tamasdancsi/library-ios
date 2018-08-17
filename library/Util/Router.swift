
import UIKit

final class Router {

    private let navigationController = UINavigationController()
    static let shared = Router()
}

// MARK: - List view related
extension Router {

    func getRootViewController() -> UINavigationController {
        navigationController.viewControllers = [ListViewController()]
        return navigationController
    }
}

// MARK: - Book view related
extension Router {

    func pushBookViewController() {
        navigationController.pushViewController(BookViewController(), animated: true)
    }
}
