import UIKit
import Combine

final class SearchViewController: UIViewController {
    
    private let filters = Filter.mockFilterModels()
    
    lazy var customTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero,
                                        leftIconImage: .named(.searchIcon),
                                        clearButtonImage: .named(.closeIcon))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: "Должность,ключевые слова", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.backgroundColor = UIColor(named: "Grey2")
        textField.returnKeyType = .next
        textField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textField.layer.cornerRadius = 8
        textField.textColor = UIColor(named: "Grey4")
        return textField
    }()
    
    lazy private var filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Grey2")
        button.setImage(.named(.filterIcon), for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 130, height: 130)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(SearchQuickFilterCell<QuickFilterView>.self)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .black
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Вакансии для вас"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "DarkBlue")
        button.setTitleColor(UIColor(named: "Gray4"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
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
    private var offers: Offers?
    
    // MARK: Public
    var viewModel: SearchInfo!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupUI()
        viewModelBinding()
    }
    
    private func setup() {
        //view.backgroundColor = .black
    }
    
    private func setupUI() {
        view.addSubviews(customTextField, filterButton, collectionView, titleLabel, tableView, moreButton)
        
        NSLayoutConstraint.activate([
            customTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customTextField.heightAnchor.constraint(equalToConstant: 40),
            customTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            customTextField.rightAnchor.constraint(equalTo: filterButton.leftAnchor, constant: -20),
            
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            filterButton.widthAnchor.constraint(equalToConstant: 40),
            filterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: customTextField.bottomAnchor, constant: 20),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 130),
            
            titleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: collectionView.rightAnchor),
            titleLabel.leftAnchor.constraint(equalTo: collectionView.leftAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: moreButton.topAnchor, constant: -20),
            
            moreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            moreButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            moreButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
    
    private func viewModelBinding() {
        viewModel.updateOffersPublisher
            .sink { [weak self] returnValue in
                guard let self = self else { return }
                self.offers = returnValue
                DispatchQueue.main.async {
                    let count = returnValue?.vacancies.count ?? 0
                    self.moreButton.setTitle(
                        "Еще \(count) \(self.pluralForm(n: count))", for: .normal
                    )
                    self.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
    //MARK: Actions
    
    @objc func filterButtonAction(sender: UIButton!) {
        print("Taped filter button action")
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

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { filters.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: SearchQuickFilterCell<QuickFilterView>.self, for: indexPath)
        let model = filters[indexPath.item]
        cell.containerView.update(with: model)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers?.vacancies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SearchVacanciesCell<VacanciesView>
        let model = offers?.vacancies[indexPath.row]
        cell.containerView.update(with: model)
        cell.containerView.tapHeartyButtonAction = { [weak self] in
            self?.viewModel.heartButtonDidTapSubject.send(model)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = offers?.vacancies[indexPath.row]
        viewModel.didTapCellVacancySubject.send(model)
    }
}
