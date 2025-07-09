import UIKit

extension UILabel {
    func setAsHeader() {
        text = "You have got 5 tasks today to complete"
        font = if let titleFont = UIFont(name: "Roboto-Bold", size: 25) { titleFont } else { font.withSize(25) }
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
    
    func setAsSubHeader() {
        textColor = .white
        font = if let titleFont = UIFont(name: "Roboto-Medium", size: 22) { titleFont } else { font.withSize(22) }
    }
}
