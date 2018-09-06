import UIKit

@IBDesignable
class BaseInjectable: UIView {

    @IBInspectable var contentView: UIView?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initXib()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initXib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initXib()
    }

    func initXib() {
        if contentView != nil { return }
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        contentView = view
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
        initXib()
        contentView?.prepareForInterfaceBuilder()
    }
}
