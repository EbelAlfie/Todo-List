import UIKit

class TodoItem: UITableViewCell {
    private lazy var taskName = {
        let textView = UILabel()
        return textView
    }()
    
    private lazy var taskDescription = {
        let textView = UILabel()
        return textView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(taskName)
        addSubview(taskDescription)
        
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: topAnchor),
            taskName.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor),
            taskDescription.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
