import UIKit

class CreateTaskVC: UIViewController {
    
    private let onTaskCreated: ((TaskModel) -> Void)
    
    private lazy var titleTextField = {
        let textField = BaseTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        textField.setAsDefaultTextField()
        textField.setPadding(newPadding: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        return textField
    }()
    
    private lazy var descriptionTextField = {
        let textField = BaseTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        textField.setAsDefaultTextField()
        textField.setPadding(newPadding: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        return textField
    }()
    
    private lazy var scheduleLabel = {
        let label = UILabel()
        label.text = "Your Task"
        label.setAsSubHeader()
        return label
    }()
    
    private lazy var newTaskButton = {
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        config.title = "Create Task"
        config.baseBackgroundColor = .purple
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(createTask), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        title = "Create New Task"
        
        if let nav = navigationController {
            nav.navigationBar.titleTextAttributes = titleAttributes
            nav.navigationBar.prefersLargeTitles = false
        }
        
        view.backgroundColor = .black
        
        setupViews()
    }
    
    init(onTaskCreated: @escaping (TaskModel) -> Void) {
        self.onTaskCreated = onTaskCreated
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Storyboard meresahkan!")
    }
    
    private func setupViews() {
        addView()
        setupScheduleLabel()
        setupTitleTextField()
        setupDescField()
        setupNewTaskButton()
    }
    
    @objc private func createTask() {
        guard let name = titleTextField.text, !name.isEmpty else {
            titleTextField.setAsError()
            return
        }
        
        guard let desc = descriptionTextField.text, !desc.isEmpty else {
            descriptionTextField.setAsError()
            return
        }
        
        let task = TaskModel(id: "ASDASD", title: name, description: desc, priority: Priority.High)
        onTaskCreated(task)
        
        navigationController?.popViewController(animated: true)
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
        view.addSubview(descriptionTextField)
        view.addSubview(newTaskButton)
    }

    private func setupScheduleLabel() {
        scheduleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scheduleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            scheduleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    private func setupTitleTextField() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: scheduleLabel.bottomAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    private func setupDescField() {
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    private func setupNewTaskButton() {
        newTaskButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            newTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
}
