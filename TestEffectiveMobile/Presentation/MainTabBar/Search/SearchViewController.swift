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
    
    // MARK: Private
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Public
    var viewModel: SearchInfo!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupUI()
        viewModelBinding()
    }
    
    private func setup() {
        view.backgroundColor = .black
    }
    
    private func setupUI() {
        view.addSubviews(customTextField, filterButton, collectionView)
        
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
            collectionView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    private func viewModelBinding() {
        
    }
    
    //MARK: Actions
    
    @objc func filterButtonAction(sender: UIButton!) {
        print("Taped filter button action")
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
