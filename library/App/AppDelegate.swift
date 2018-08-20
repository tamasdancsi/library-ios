
import UIKit
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupLibs()
        displayRootViewController()
        return true
    }

    func setupLibs() {
        // Disable logging http traffic
        Logging.URLRequests = { _ in return false }
    }

    func displayRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = Router.shared.getRootViewController()
        self.window?.makeKeyAndVisible()
    }
}
