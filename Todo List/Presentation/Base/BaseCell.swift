import UIKit

protocol BaseCell: UITableViewCell {
    associatedtype DataType
    
    static var identifier: String { get }
    
    func bindData(data: DataType)
}
