import UIKit

class TodoItem: UITableViewCell, BaseCell {
    static var identifier: String = "Todo Item"
    
    private lazy var priorityHighlight = {
        let highlight = UIView()
        return highlight
    }()
    
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
        layer.cornerRadius = 10
        addSubview(taskName)
        addSubview(taskDescription)
        
        NSLayoutConstraint.activate([
            priorityHighlight.leadingAnchor.constraint(equalTo: leadingAnchor),
            priorityHighlight.topAnchor.constraint(equalTo: topAnchor),
            priorityHighlight.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            taskName.topAnchor.constraint(equalTo: topAnchor),
            taskName.leadingAnchor.constraint(equalTo: priorityHighlight.trailingAnchor),
            
            taskDescription.leadingAnchor.constraint(equalTo: taskName.leadingAnchor),
            taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor),
            taskDescription.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func bindData(data: TaskModel) {
        priorityHighlight.backgroundColor = switch(data.priority) {
            case .High: UIColor(red: 250, green: 203, blue: 186, alpha: 1)
            case .Medium: UIColor(red: 215, green: 240, blue: 255, alpha: 1)
            case .Low: UIColor(red: 250, green: 217, blue: 255, alpha: 1)
        }
        taskName.text = data.title
        taskDescription.text = data.description
    }
}
