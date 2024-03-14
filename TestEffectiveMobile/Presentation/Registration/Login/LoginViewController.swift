import UIKit
import Combine

final class LoginViewController: UIViewController {
    
    lazy var enterLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход в личный кабинет"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var findWorkView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Grey1")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
//        view.alpha = 0.4
        return view
    }()
    
    lazy var findWorkLabel: UILabel = {
        let label = UILabel()
        label.text = "Поиск работы"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy private var customTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero,
                                        leftIconImage: UIImage(named: "emailIcon")!,
                                        clearButtonImage: UIImage(named: "closeIcon")!)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: "Электронная почта или телефон", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.backgroundColor = UIColor(named: "Grey2")
        textField.keyboardType = .default
        textField.returnKeyType = .next
        textField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textField.layer.cornerRadius = 8
        textField.textColor = UIColor(named: "Grey4")
        textField.delegate = self
        return textField
    }()
    
    lazy private var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.backgroundColor = UIColor(named: "DarkBlue")
        button.setTitleColor(UIColor(named: "Gray4"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.alpha = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var enterWithPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти с паролем", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(UIColor(named: "Blue"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: Private
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Public
    var viewModel: LoginInfo!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        viewModelBinding()
        setupUI()
    }
    
    private func setup() {
        navigationItem.hidesBackButton  = true
        navigationItem.leftBarButtonItem = nil
        view.backgroundColor = .black
        //self.hideKeyboardWhenTappedAround()
    }
    
    private func viewModelBinding() {
        viewModel.errorPublisher
            .sink { [weak self] error in self?.showAlert(title: error.title, subtitle: error.subtitle) }
            .store(in: &cancellables)

        viewModel.nextButtonStatePublisher
            .sink { [weak self] returnValue in
                guard let self = self else { return }
                self.continueButton.isEnabled = returnValue

                self.continueButton.backgroundColor = returnValue
                ? UIColor(named: "Blue")!
                : UIColor(named: "DarkBlue")!
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        view.addSubviews(enterLabel, findWorkView)
        findWorkView.addSubviews(findWorkLabel, customTextField, continueButton, enterWithPasswordButton)
        
        NSLayoutConstraint.activate([
            enterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            enterLabel.heightAnchor.constraint(equalToConstant: 50),
            enterLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            enterLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            findWorkView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            findWorkView.heightAnchor.constraint(equalToConstant: 180),
            findWorkView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            findWorkView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            findWorkLabel.topAnchor.constraint(equalTo: findWorkView.topAnchor, constant: 24),
            findWorkLabel.leftAnchor.constraint(equalTo: findWorkView.leftAnchor, constant: 16),
            findWorkLabel.rightAnchor.constraint(equalTo: findWorkView.rightAnchor, constant: -16),
            
            customTextField.topAnchor.constraint(equalTo: findWorkLabel.bottomAnchor, constant: 16),
            customTextField.leftAnchor.constraint(equalTo: findWorkLabel.leftAnchor),
            customTextField.rightAnchor.constraint(equalTo: findWorkLabel.rightAnchor),
            customTextField.heightAnchor.constraint(equalToConstant: 40),
            
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            continueButton.topAnchor.constraint(equalTo: customTextField.bottomAnchor, constant: 20),
            continueButton.leftAnchor.constraint(equalTo: customTextField.leftAnchor),
            continueButton.widthAnchor.constraint(equalTo: findWorkView.widthAnchor, multiplier: 0.4),
            
            enterWithPasswordButton.heightAnchor.constraint(equalToConstant: 40),
            enterWithPasswordButton.topAnchor.constraint(equalTo: continueButton.topAnchor),
            enterWithPasswordButton.rightAnchor.constraint(equalTo: customTextField.rightAnchor),
            enterWithPasswordButton.widthAnchor.constraint(equalTo: findWorkView.widthAnchor, multiplier: 0.5),
        ])
    }
    
    //MARK: Actions
    
    @objc func continueButtonAction(sender: UIButton!) {
        viewModel.nextButtonDidTapSubject.send()
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case customTextField:
            viewModel.email.send(textField.text)
        default: break
        }
    }
}

