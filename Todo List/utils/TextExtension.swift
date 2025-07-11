import UIKit

extension UILabel {
    func setAsHeader() {
        font = if let titleFont = UIFont(name: "Roboto-Bold", size: 25) { titleFont } else { font.withSize(25) }
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
    
    func setAsSubHeader() {
        textColor = .white
        font = if let titleFont = UIFont(name: "Roboto-Medium", size: 22) { titleFont } else { font.withSize(22) }
    }
}

extension UITextField {
    func setAsDefaultTextField() {
        layer.cornerRadius = 10
        backgroundColor = Gray
        textColor = .white
    }
    
    func setAsError() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 3
    }
}

extension UITextView {
    func setAsDefaultTextField() {
        layer.cornerRadius = 10
        backgroundColor = Gray
        textColor = .white
    }
    
    func setAsError() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 3
    }
}
