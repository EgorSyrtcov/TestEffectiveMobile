import UIKit
import Combine

final class DetailViewController: UIViewController {
    
    lazy private var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(.named(.backIcon), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonDidTapAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(.named(.favoriteIcon), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(backButtonDidTapAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var sharedButton: UIButton = {
        let button = UIButton()
        button.setImage(.named(.sharedIcon), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(backButtonDidTapAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var lookButton: UIButton = {
        let button = UIButton()
        button.setImage(.named(.lookIcon), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(backButtonDidTapAction), for: .touchUpInside)
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .red
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var jobInfoView = JobInfoView()
    
    // MARK: Private
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Public
    var viewModel: DetailInfo!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        viewModelBinding()
        setupUI()
    }
    
    private func setup() {
        view.backgroundColor = .black
    }
    
    private func viewModelBinding() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = containerView.frame.size
    }
    
    private func setupUI() {
        
        view.addSubviews(filterButton, favoriteButton, sharedButton, lookButton, scrollView)
        scrollView.addSubviews(containerView)
        containerView.addSubviews(jobInfoView)
        
        NSLayoutConstraint.activate([
            filterButton.heightAnchor.constraint(equalToConstant: 50),
            filterButton.widthAnchor.constraint(equalToConstant: 50),
            filterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            favoriteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            favoriteButton.topAnchor.constraint(equalTo: filterButton.topAnchor),
            
            sharedButton.heightAnchor.constraint(equalToConstant: 50),
            sharedButton.widthAnchor.constraint(equalToConstant: 50),
            sharedButton.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor),
            sharedButton.topAnchor.constraint(equalTo: favoriteButton.topAnchor),
            
            lookButton.heightAnchor.constraint(equalToConstant: 50),
            lookButton.widthAnchor.constraint(equalToConstant: 50),
            lookButton.rightAnchor.constraint(equalTo: sharedButton.leftAnchor),
            lookButton.topAnchor.constraint(equalTo: sharedButton.topAnchor),
            
            scrollView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 10),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 1350),
            
            jobInfoView.topAnchor.constraint(equalTo: containerView.topAnchor),
            jobInfoView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            jobInfoView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
        ])
    }
    
    //MARK: Actions
    
    @objc func backButtonDidTapAction(sender: UIButton!) {
        viewModel.backButtonDidTapSubject.send()
    }
    
}
