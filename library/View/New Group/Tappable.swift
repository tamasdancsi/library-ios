import UIKit

protocol TappableDelegate: AnyObject {
    func onTappableTap(_ sender: Tappable)
}

class Tappable: BaseInjectable {

    @IBInspectable @IBOutlet weak var titleLabel: UILabel!
    @IBInspectable @IBOutlet weak var descriptionLabel: UILabel!

    weak var delegate: TappableDelegate?
    fileprivate var tapRecognizer: UITapGestureRecognizer!

    override func setupView() {
        if tapRecognizer != nil { return }
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.addGestureRecognizer(tapRecognizer)
    }

    public func set(title: String, description: String?) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
}

// MARK: - Action handling
extension Tappable {

    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        delegate?.onTappableTap(self)
    }
}
