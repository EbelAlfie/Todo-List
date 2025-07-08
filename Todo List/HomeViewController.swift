import UIKit

class HomeViewController: UIViewController {

    private lazy var headerText = {
        let header = UILabel()
        header.textColor = .white
        header.text = "You have got 5 tasks today to complete"
        header.font = if let titleFont = UIFont(name: "Roboto-Bold", size: 25) { titleFont } else { header.font.withSize(25) }
        header.numberOfLines = 0
        header.lineBreakMode = .byWordWrapping
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todo"
        view.backgroundColor = .black
        setupHeaderTitle()
    }

    private func setupHeaderTitle() {
        view.addSubview(headerText)
        headerText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            headerText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

extension HomeViewController {
    
    private func setupTodoListView() {
        
    }
    
}
