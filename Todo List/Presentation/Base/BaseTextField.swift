import UIKit

class BaseTextField: UITextField {
    var textPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    func setPadding(newPadding: UIEdgeInsets) {
        textPadding = newPadding
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}
