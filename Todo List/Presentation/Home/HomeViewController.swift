import UIKit

class HomeViewController: UIViewController {

    private lazy var headerText = {
        let header = UILabel()
        header.textColor = .white
        header.setAsHeader()
        return header
    }()
    
    private lazy var todayListTitle = {
        let title = UILabel()
        title.textColor = .white
        title.text = "Today's List"
        title.font = if let titleFont = UIFont(name: "Roboto-Medium", size: 22) { titleFont } else { title.font.withSize(22) }
        return title
    }()
    
    private lazy var seeAllButton = {
        let seeAll = UIButton()
        seeAll.setTitleColor(.purple, for: .normal)
        seeAll.setTitle("See All", for: .normal)
        seeAll.titleLabel?.font = if let titleFont = UIFont(name: "Roboto-Regular", size: 18) { titleFont } else { seeAll.titleLabel?.font.withSize(18)
        }
        for f in UIFont.familyNames {
            for n in UIFont.fontNames(forFamilyName: f) {
                print(n)
            }
        }
        return seeAll
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todo"
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
}

extension HomeViewController {
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
            tableView.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor)
        ])
    }
}
