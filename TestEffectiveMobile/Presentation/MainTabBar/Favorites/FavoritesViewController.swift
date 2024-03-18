import UIKit
import Combine

final class FavoritesViewController: UIViewController {
    
    private var vacancies = [Vacancy]()

    private let lookPeopleLabel: UILabel = {
        let label = UILabel()
        label.text = "Избранное"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let vacanciesCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1 вакансия"
        label.textAlignment = .left
        label.textColor = UIColor(named: "Grey3")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerClassForCell(SearchVacanciesCell<VacanciesView>.self)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 285
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Private
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Public
    var viewModel: FavoritesInfo!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        viewModelBinding()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateVacancies()
    }
    
    private func setup() {
        view.backgroundColor = .black
    }
    
    private func viewModelBinding() {
        
    }
    
    private func updateVacancies() {
        self.vacancies = LocalService().vacancies
        let count = vacancies.count
        vacanciesCountLabel.text = "\(count) \(pluralForm(n: count))"
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.addSubviews(lookPeopleLabel, vacanciesCountLabel, tableView)
        
        NSLayoutConstraint.activate([
            lookPeopleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lookPeopleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            lookPeopleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            vacanciesCountLabel.topAnchor.constraint(equalTo: lookPeopleLabel.bottomAnchor, constant: 50),
            vacanciesCountLabel.leftAnchor.constraint(equalTo: lookPeopleLabel.leftAnchor),
            vacanciesCountLabel.rightAnchor.constraint(equalTo: lookPeopleLabel.rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: vacanciesCountLabel.bottomAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func pluralForm(n: Int) -> String {
        let remainder10 = n % 10
        let remainder100 = n % 100

        if remainder10 == 1 && remainder100 != 11 {
            return "вакансия"
        } else if remainder10 >= 2 && remainder10 <= 4 && (remainder100 < 10 || remainder100 >= 20) {
            return "вакансии"
        } else {
            return "вакансий"
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacancies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SearchVacanciesCell<VacanciesView>
        let model = vacancies[indexPath.row]
        cell.containerView.update(with: model)
        return cell
    }
}
