import UIKit

protocol CreateTaskProtocol: AnyObject {
    func onCreatedTask(task: TaskModel)
}

class CreateTaskVC: UIViewController {
    
    weak var delegate: CreateTaskProtocol?
    
    var taskEdit: TaskModel?
    
    private lazy var scheduleLabel = {
        let label = UILabel()
        label.text = "Your Task"
        label.setAsSubHeader()
        return label
    }()
    
    private lazy var titleTextField = {
        let textField = BaseTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        textField.setAsDefaultTextField()
        textField.setPadding(newPadding: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        
        if isEditMode() {
            textField.text = taskEdit?.title
        }
        textField.addTarget(self, action: #selector(onTextChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var descriptionTextField = {
        let textField = BaseTextView()
        textField.contentInset = UIEdgeInsets(top: 5, left: 12, bottom: 12, right: 12)
        textField.placeholder = "Description"
        textField.setAsDefaultTextField()
        if isEditMode() {
            textField.text = taskEdit?.title
        }
        return textField
    }()
    
    private lazy var markDoneLabel = {
        let doneText = UILabel()
        doneText.text = "Mark as done"
        doneText.textColor = .white
        return doneText
    }()
    
    private lazy var doneSwitch = {
        let toggle = UISwitch()
        toggle.setOn(taskEdit?.isDone ?? false, animated: true)
        return toggle
    }()
    
    private lazy var newTaskButton = {
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        
        config.title =  if isEditMode() {
            "Update Task"
        } else {
            "Create Task"
        }
        
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
    
    private func isEditMode() -> Bool {
        return taskEdit != nil
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
        
        let task = if isEditMode(), let task = taskEdit {
            TaskModel(id: task.id, title: name, description: desc, priority: Priority.High, isDone: doneSwitch.isOn)
        } else {
            TaskModel(id: UUID().uuidString, title: name, description: desc, priority: Priority.High, isDone: doneSwitch.isOn)
        }
         
        delegate?.onCreatedTask(task: task)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onTextChanged() {
        titleTextField.layer.borderColor = .none
    }
}


extension CreateTaskVC {
    
    private func setupViews() {
        addView()
        setupScheduleLabel()
        setupTitleTextField()
        setupDescField()
        setupNewTaskButton()
        setupDoneText()
        setupDoneSwitch()
    }
    
    private func addView() {
        view.addSubview(scheduleLabel)
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(newTaskButton)
        view.addSubview(doneSwitch)
        view.addSubview(markDoneLabel)

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
            descriptionTextField.heightAnchor.constraint(equalToConstant: 100),
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
    
    private func setupDoneText() {
        markDoneLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            markDoneLabel.trailingAnchor.constraint(equalTo: doneSwitch.leadingAnchor, constant: -5),
            markDoneLabel.topAnchor.constraint(equalTo: doneSwitch.topAnchor),
            markDoneLabel.bottomAnchor.constraint(equalTo: doneSwitch.bottomAnchor),
        ])
    }
    
    private func setupDoneSwitch() {
        doneSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            doneSwitch.bottomAnchor.constraint(equalTo: newTaskButton.topAnchor, constant: -10)
        ])
    }
}
