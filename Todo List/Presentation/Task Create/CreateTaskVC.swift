import UIKit

class CreateTaskVC: UIViewController {
    
    private let onTaskCreated: ((TaskModel) -> Void)
    
    init(onTaskCreated: @escaping (TaskModel) -> Void) {
        self.onTaskCreated = onTaskCreated
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Belum dipanggil")
    }
    
    private lazy var titleTextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        return textField
    }()
    
    private lazy var descriptionTextField = {
        let textField = UITextField()
        textField.placeholder = "Description"
        return textField
    }()
    
    private lazy var scheduleLabel = {
        let label = UILabel()
        label.text = "Schedule"
        label.setAsSubHeader()
        return label
    }()
    
    private lazy var createButton = {
        let button = UIButton()
        button.setTitle("Create Task", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.largeContentTitle = "Create New Task"
        view.backgroundColor = .black
        
        setupViews()
    }
    
    private func setupViews() {
        
    }
    
    private func createTask() {
        
    }
    
    static func newViewController(
        onNewTaskCreated: @escaping (TaskModel) -> Void
    ) -> CreateTaskVC {
        let viewController = CreateTaskVC(onTaskCreated: onNewTaskCreated)
        return viewController
    }
}


extension CreateTaskVC {
    
    private func addView() {
        view.addSubview(scheduleLabel)
        view.addSubview(titleTextField)
    }
    
    private func setupScheduleLabel() {
        scheduleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scheduleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    private func setupTitleTextField() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
}
