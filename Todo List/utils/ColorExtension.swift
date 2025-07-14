import UIKit

func setColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

func setCGColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> CGColor {
    return CGColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}
