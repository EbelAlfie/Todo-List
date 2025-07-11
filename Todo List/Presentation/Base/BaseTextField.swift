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

class BaseTextView: UITextView, UITextViewDelegate {
    
    private let placeholderLabel = UILabel()

    var placeholder: String? {
        didSet { placeholderLabel.text = placeholder }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.isHidden = !text.isEmpty
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        delegate = self
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white

        textContainer.lineFragmentPadding = 0

        placeholderLabel.font = font
        placeholderLabel.textColor = .white
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: textContainerInset.top),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textContainerInset.left),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textContainerInset.right)
        ])
    }

    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        layer.borderColor = .none
    }
}
