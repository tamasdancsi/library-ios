import UIKit

protocol TappableDelegate: AnyObject {
    func onTappableTap(_ sender: Tappable)
}

class Tappable: BaseInjectable {

    @IBInspectable @IBOutlet weak var button: UIButton!
    @IBInspectable @IBOutlet weak var titleLabel: UILabel!

    weak var delegate: TappableDelegate?

    public func set(title: String, label: String?) {
        self.button.setTitle(title, for: .normal)
        self.titleLabel.text = label
    }
}

// MARK: - Action handling
extension Tappable {

    @IBAction func onButtonTap(_ sender: Any) {
        delegate?.onTappableTap(self)
    }
}
