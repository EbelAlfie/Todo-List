import UIKit

class TodoItem: UITableViewCell, BaseCell {
    static var identifier: String = "Todo Item"
    
    var callback: TaskItemCallback?
    
    private lazy var rootView = {
        let root = UIView()
        root.clipsToBounds = true
        root.layer.cornerRadius = 10
        root.backgroundColor = Gray
        return root
    }()
    
    private lazy var priorityHighlight = {
        let highlight = UIView()
        return highlight
    }()
    
    private lazy var taskName = {
        let textView = UILabel()
        textView.textColor = .white
        return textView
    }()
    
    private lazy var taskDescription = {
        let textView = UILabel()
        textView.textColor = .white
        return textView
    }()
    
    private lazy var deleteIcon = {
        let icon = UIImage(named: "DeleteIcon")
        return icon
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("Story board meresahkan")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .clear
        
        contentView.addSubview(rootView)
        
        rootView.addSubview(priorityHighlight)
        rootView.addSubview(taskName)
        rootView.addSubview(taskDescription)
        
        priorityHighlight.translatesAutoresizingMaskIntoConstraints = false
        rootView.translatesAutoresizingMaskIntoConstraints = false
        taskName.translatesAutoresizingMaskIntoConstraints = false
        taskDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rootView.topAnchor.constraint(equalTo: contentView.topAnchor),
            rootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            priorityHighlight.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            priorityHighlight.topAnchor.constraint(equalTo: rootView.topAnchor),
            priorityHighlight.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
            priorityHighlight.widthAnchor.constraint(equalToConstant: 10),
            
            taskName.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 15),
            taskName.leadingAnchor.constraint(equalTo: priorityHighlight.trailingAnchor, constant: 10),
            
            taskDescription.leadingAnchor.constraint(equalTo: taskName.leadingAnchor),
            taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 10),
            taskDescription.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -15)
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
