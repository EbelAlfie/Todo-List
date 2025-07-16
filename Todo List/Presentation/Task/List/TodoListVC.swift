import UIKit

class TodoListVC: UIViewController {
    
    private var tasksList: [TaskModel] = []

    private lazy var headerText = {
        let header = UILabel()
        header.textColor = .white
        header.setAsHeader()
        header.text = "You have got 0 tasks today to complete"

        return header
    }()
    
    private lazy var todayListTitle = {
        let title = UILabel()
        title.text = "Today's List"
        title.setAsSubHeader()
        return title
    }()
    
    private lazy var addTaskButton = {
        let seeAll = UIButton()
        seeAll.setTitleColor(.purple, for: .normal)
        seeAll.setTitle("Add task", for: .normal)
        seeAll.titleLabel?.font = if let titleFont = UIFont(name: "Roboto-Regular", size: 16) { titleFont } else { seeAll.titleLabel?.font.withSize(16)
        }
        seeAll.addTarget(self, action: #selector(onAddTaskClicked), for: .touchUpInside)
        return seeAll
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(TodoItem.self, forCellReuseIdentifier: TodoItem.identifier)
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var emptyContent = {
        let emptyLabel = UILabel()
        emptyLabel.text = "You have no task"
        emptyLabel.textColor = .lightGray
        
        let stackView = UIStackView(arrangedSubviews: [emptyLabel])
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
    }
    
    private func setupViews() {
        addAllViews()
        setupHeaderTitle()
        setupTodoListTitle()
        setupAddTaskButton()
        setupTodoListView()
        setupEmptyContent()
    }
    
    private func goToCreateTaskVC(task: TaskModel?) {
        let createTaskVc = CreateTaskVC()
        createTaskVc.taskEdit = task
        createTaskVc.delegate = self
        navigationController?.pushViewController(createTaskVc, animated: true)
    }
}

/**Table View**/
extension TodoListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoItem.identifier, for: indexPath)
        if let todoCell = cell as? TodoItem {
            todoCell.callback = self
            todoCell.bindData(data: tasksList[indexPath.item])
        }
        return cell
    }
}

/**Table item manager**/
extension TodoListVC: CreateTaskProtocol, TodoItemCallback {
    func onCreatedTask(task: TaskModel) {
        let index: Int? = tasksList.firstIndex { item in item.id == task.id }
        
        if let selectedPosition = index {
            self.tasksList[selectedPosition] = task
        } else {
            self.tasksList.append(task)
        }
        
        updateView()
        
        self.tableView.reloadData()
    }
    
    func onDelete(task: TaskModel) {
        guard let position = tasksList.firstIndex(where: { item in item.id == task.id }) else { return }
        self.tasksList.remove(at: position)
        updateView()
        self.tableView.reloadData()
    }
    
    func onClicked(task: TaskModel) {
        goToCreateTaskVC(task: task)
    }
}

/**Listeners**/
private extension TodoListVC {
    @objc func onAddTaskClicked() {
        goToCreateTaskVC(task: nil)
    }
}

/**UIKIT manager*/
private extension TodoListVC {
    func addAllViews() {
        view.addSubview(headerText)
        view.addSubview(todayListTitle)
        view.addSubview(addTaskButton)
        view.addSubview(tableView)
        view.addSubview(emptyContent) //Harusnya ga boleh
    }
    
    func updateView() {
        updateHeaderTitleText()
        updateItemState()
    }
    
    func updateHeaderTitleText() {
        headerText.text = "You have got \(self.tasksList.count) tasks today to complete"
    }
    
    func updateItemState() {
        emptyContent.isHidden = tasksList.count > 0
        tableView.isHidden = tasksList.count <= 0
    }
    
    func setupHeaderTitle() {
        headerText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            headerText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
        
    func setupTodoListTitle() {
        todayListTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayListTitle.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 30),
            todayListTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todayListTitle.trailingAnchor.constraint(equalTo: addTaskButton.trailingAnchor, constant: -20)
        ])
    }
    
    func setupAddTaskButton() {
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addTaskButton.topAnchor.constraint(equalTo: todayListTitle.topAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: todayListTitle.bottomAnchor),
            addTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func setupTodoListView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: todayListTitle.bottomAnchor, constant: 12),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupEmptyContent() {
        emptyContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyContent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyContent.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
