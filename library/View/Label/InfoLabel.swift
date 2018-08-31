import UIKit

class InfoLabel: BaseInjectable {

    @IBInspectable @IBOutlet weak var label: UILabel!
    @IBInspectable @IBOutlet weak var titleLabel: UILabel!

    public func set(title: String, label: String) {
        self.label.text = label
        self.titleLabel.text = title
    }
}
