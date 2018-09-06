import UIKit

@IBDesignable
class BaseInjectable: UIView {

    @IBInspectable var contentView: UIView?

    // Inherited classes may override this
    func setupView() {}

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {
        if contentView != nil { return }
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        contentView = view
        setupView()
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let name = String(describing: type(of: self))
        if (bundle.path(forResource: name, ofType: "nib") == nil) {
            print("[BaseInjectable] error: missing nib file with name:", name)
            return nil
        }
        let nib = UINib(nibName: name, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        contentView?.prepareForInterfaceBuilder()
    }
}
