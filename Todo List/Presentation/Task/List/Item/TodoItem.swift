import UIKit

class TodoItem: UITableViewCell, BaseCell {
    static var identifier: String = "Todo Item"
    
    var callback: TodoItemCallback?
    private var item: TaskModel?
    
    private lazy var rootView = {
        let root = UIControl()
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
        let icon = UIImage(named: "DeleteIcon")?.withTintColor(.red)
        let iconView = UIButton()
        iconView.setImage(icon, for: .normal)
        return iconView
    }()
    
    private lazy var doneLabel = {
        let label = BaseLabel()
        label.textColor = .white
        label.backgroundColor = UIColor.systemRed
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.padding = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        return label
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
        
        setupViews()
    }
    
    func bindData(data: TaskModel) {
        self.item = data
        
        deleteIcon.addTarget(self, action: #selector(onDelete), for: .touchUpInside)
        
        rootView.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        priorityHighlight.backgroundColor = switch(data.priority) {
            case .High: setColor(red: 250, green: 203, blue: 186, alpha: 1)
            case .Medium: setColor(red: 215, green: 240, blue: 255, alpha: 1)
            case .Low: setColor(red: 250, green: 217, blue: 255, alpha: 1)
        }
        updateDoneLabel(data.isDone)
        taskName.text = data.title
        taskDescription.text = data.description
    }
    
    @objc private func onDelete() {
        guard let item = self.item else { return }
        callback?.onDelete(task: item)
    }
    
    @objc private func onClick() {
        guard let item = self.item else { return }
        callback?.onClicked(task: item)
    }
}

extension TodoItem {
    private func setupViews() {
        rootView.addSubview(deleteIcon)
        rootView.addSubview(priorityHighlight)
        rootView.addSubview(taskName)
        rootView.addSubview(taskDescription)
        rootView.addSubview(doneLabel)
        
        deleteIcon.translatesAutoresizingMaskIntoConstraints = false
        priorityHighlight.translatesAutoresizingMaskIntoConstraints = false
        rootView.translatesAutoresizingMaskIntoConstraints = false
        taskName.translatesAutoresizingMaskIntoConstraints = false
        taskDescription.translatesAutoresizingMaskIntoConstraints = false
        doneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rootView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            deleteIcon.widthAnchor.constraint(equalToConstant: 26),
            deleteIcon.heightAnchor.constraint(equalToConstant: 26),
            
            deleteIcon.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -10),
            deleteIcon.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            
            priorityHighlight.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            priorityHighlight.topAnchor.constraint(equalTo: rootView.topAnchor),
            priorityHighlight.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
            priorityHighlight.widthAnchor.constraint(equalToConstant: 10),
            
            taskName.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 15),
            taskName.leadingAnchor.constraint(equalTo: priorityHighlight.trailingAnchor, constant: 10),
            taskName.trailingAnchor.constraint(equalTo: doneLabel.leadingAnchor),
            
            taskDescription.leadingAnchor.constraint(equalTo: taskName.leadingAnchor),
            taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 10),
            taskDescription.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -15),
            taskDescription.trailingAnchor.constraint(lessThanOrEqualTo: taskName.trailingAnchor),
            
            doneLabel.leadingAnchor.constraint(equalTo: taskName.trailingAnchor),
            doneLabel.topAnchor.constraint(equalTo: taskName.topAnchor),
            doneLabel.bottomAnchor.constraint(equalTo: taskName.bottomAnchor),
            doneLabel.trailingAnchor.constraint(lessThanOrEqualTo: deleteIcon.leadingAnchor, constant: -10),
        ])
    }
    
    private func updateDoneLabel(_ isDone: Bool) {
        doneLabel.text = if isDone {
            "Done"
        } else {
            "Pending"
        }
        doneLabel.backgroundColor = if isDone { .green } else { .systemOrange }
    }
}
