import UIKit

class TodoListVC: UIViewController {
    
    private var tasksList: [TaskModel] = []

    private lazy var headerText = {
        let header = UILabel()
        header.textColor = .white
        header.setAsHeader()
        return header
    }()
    
    private lazy var todayListTitle = {
        let title = UILabel()
        title.text = "Today's List"
        title.setAsSubHeader()
        return title
    }()
    
    private lazy var seeAllButton = {
        let seeAll = UIButton()
        seeAll.setTitleColor(.purple, for: .normal)
        seeAll.setTitle("Add task", for: .normal)
        seeAll.titleLabel?.font = if let titleFont = UIFont(name: "Roboto-Regular", size: 16) { titleFont } else { seeAll.titleLabel?.font.withSize(16)
        }
        seeAll.addTarget(self, action: #selector(goToCreateTaskVC), for: .touchUpInside)
        return seeAll
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(TodoItem.self, forCellReuseIdentifier: TodoItem.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
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
        setupSeeAllButton()
        setupTodoListView()
    }
    
    @objc private func goToCreateTaskVC() {
        let createTaskVc = CreateTaskVC()
        createTaskVc.delegate = self
        navigationController?.pushViewController(createTaskVc, animated: true)
    }
}

extension TodoListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoItem.identifier, for: indexPath)
        if let todoCell = cell as? TodoItem {
            todoCell.bindData(data: tasksList[indexPath.item])
        }
        return cell
    }
}

extension TodoListVC: CreateTaskProtocol {
    func onCreatedTask(task: TaskModel) {
        self.tasksList.append(task)
        self.tableView.reloadData()
    }
}

//UI Manager
extension TodoListVC {
    private func addAllViews() {
        view.addSubview(headerText)
        view.addSubview(todayListTitle)
        view.addSubview(seeAllButton)
        view.addSubview(tableView)
    }
    
    private func setupHeaderTitle() {
        headerText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            headerText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupTodoListTitle() {
        todayListTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayListTitle.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 30),
            todayListTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todayListTitle.trailingAnchor.constraint(equalTo: seeAllButton.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupSeeAllButton() {
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seeAllButton.topAnchor.constraint(equalTo: todayListTitle.topAnchor),
            seeAllButton.bottomAnchor.constraint(equalTo: todayListTitle.bottomAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func setupTodoListView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: todayListTitle.bottomAnchor, constant: 12),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
}
