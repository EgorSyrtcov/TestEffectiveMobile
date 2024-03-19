import UIKit
import Combine

final class DetailViewController: UIViewController {
    
    private var vacancy: Vacancy?
    
    private lazy var jobInfoView = JobInfoView(frame: .zero, vacancy: vacancy)
    private lazy var userStatusIndicatorView = UserStatusIndicatorView(frame: .zero, vacancy: vacancy)
    private lazy var addressInfoView = AddressInfoView(frame: .zero, vacancy: vacancy)
    private lazy var descriptionInfoView = DescriptionInfoView(frame: .zero, vacancy: vacancy)
    
    lazy private var backButton: UIButton = {
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
        button.addTarget(self, action: #selector(replyButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var sharedButton: UIButton = {
        let button = UIButton()
        button.setImage(.named(.sharedIcon), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(replyButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var lookButton: UIButton = {
        let button = UIButton()
        button.setImage(.named(.lookIcon), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(replyButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    lazy private var replyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Green")
        button.setTitle("Откликнуться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(replyButtonAction), for: .touchUpInside)
        return button
    }()
    
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
        viewModel.updateVacancyPublisher
            .sink { [weak self] returnValue in
                self?.vacancy = returnValue
            }
            .store(in: &cancellables)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = containerView.frame.size
    }
    
    private func setupUI() {
        
        view.addSubviews(scrollView, backButton, favoriteButton, sharedButton, lookButton)
        scrollView.addSubviews(containerView)
        containerView.addSubviews(jobInfoView, userStatusIndicatorView, addressInfoView, descriptionInfoView, replyButton)
        
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            favoriteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            favoriteButton.topAnchor.constraint(equalTo: backButton.topAnchor),
            
            sharedButton.heightAnchor.constraint(equalToConstant: 50),
            sharedButton.widthAnchor.constraint(equalToConstant: 50),
            sharedButton.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor),
            sharedButton.topAnchor.constraint(equalTo: favoriteButton.topAnchor),
            
            lookButton.heightAnchor.constraint(equalToConstant: 50),
            lookButton.widthAnchor.constraint(equalToConstant: 50),
            lookButton.rightAnchor.constraint(equalTo: sharedButton.leftAnchor),
            lookButton.topAnchor.constraint(equalTo: sharedButton.topAnchor),
            
            scrollView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            //containerView.heightAnchor.constraint(equalToConstant: 1350),
            
            jobInfoView.topAnchor.constraint(equalTo: containerView.topAnchor),
            jobInfoView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            jobInfoView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            
            userStatusIndicatorView.topAnchor.constraint(equalTo: jobInfoView.bottomAnchor, constant: 10),
            userStatusIndicatorView.rightAnchor.constraint(equalTo: jobInfoView.rightAnchor),
            userStatusIndicatorView.leftAnchor.constraint(equalTo: jobInfoView.leftAnchor),
            
            addressInfoView.topAnchor.constraint(equalTo: userStatusIndicatorView.bottomAnchor, constant: 20),
            addressInfoView.rightAnchor.constraint(equalTo: userStatusIndicatorView.rightAnchor, constant: -10),
            addressInfoView.leftAnchor.constraint(equalTo: userStatusIndicatorView.leftAnchor, constant: 10),
            addressInfoView.heightAnchor.constraint(equalToConstant: 140),
            
            descriptionInfoView.topAnchor.constraint(equalTo: addressInfoView.bottomAnchor, constant: 20),
            descriptionInfoView.rightAnchor.constraint(equalTo: addressInfoView.rightAnchor),
            descriptionInfoView.leftAnchor.constraint(equalTo: addressInfoView.leftAnchor),
            descriptionInfoView.bottomAnchor.constraint(equalTo: replyButton.topAnchor, constant: -20),
            
            replyButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            replyButton.leftAnchor.constraint(equalTo: descriptionInfoView.leftAnchor, constant: 20),
            replyButton.rightAnchor.constraint(equalTo: descriptionInfoView.rightAnchor, constant: -20),
            replyButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    //MARK: Actions
    
    @objc func backButtonDidTapAction(sender: UIButton!) {
        viewModel.backButtonDidTapSubject.send()
    }
    
    @objc func replyButtonAction(sender: UIButton!) {
        print("Нажата кнопка")
    }
    
}
