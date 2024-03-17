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
    
    lazy var findWorkView: FindWorkView = {
        let findView = FindWorkView()
        findView.customTextField.delegate = self
        findView.continueButton.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
        findView.enterWithPasswordButton.addTarget(self, action: #selector(enterWithPasswordAction), for: .touchUpInside)
        return findView
    }()
    
    lazy var findEmployeeView: FindEmployeeView = {
        let findEmployeeView = FindEmployeeView()
        findEmployeeView.continueButton.addTarget(self, action: #selector(tapedButtonFindEmployeeAction), for: .touchUpInside)
        return findEmployeeView
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
    }
    
    private func viewModelBinding() {
        viewModel.errorPublisher
            .sink { [weak self] _ in
                self?.findWorkView.customTextField.layer.borderColor = UIColor.red.cgColor
                self?.findWorkView.customTextField.layer.borderWidth = 1.0
                self?.findWorkView.errorLabel.isHidden = false
            }
            .store(in: &cancellables)

        viewModel.nextButtonStatePublisher
            .sink { [weak self] returnValue in
                guard let self = self else { return }
                self.findWorkView.continueButton.isEnabled = returnValue

                self.findWorkView.continueButton.backgroundColor = returnValue
                ? UIColor(named: "Blue")!
                : UIColor(named: "DarkBlue")!
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        view.addSubviews(enterLabel, findWorkView, findEmployeeView)
        
        NSLayoutConstraint.activate([
            enterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            enterLabel.heightAnchor.constraint(equalToConstant: 50),
            enterLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            enterLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            findWorkView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            findWorkView.heightAnchor.constraint(equalToConstant: 180),
            findWorkView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            findWorkView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            findEmployeeView.topAnchor.constraint(equalTo: findWorkView.bottomAnchor, constant: 20),
            findEmployeeView.heightAnchor.constraint(equalToConstant: 140),
            findEmployeeView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            findEmployeeView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        ])
    }
    
    //MARK: Actions
    
    @objc func continueButtonAction(sender: UIButton!) {
        viewModel.nextButtonDidTapSubject.send()
    }
    
    @objc func enterWithPasswordAction(sender: UIButton!) {
        print("Taped button enterWithPassword")
    }
    
    @objc func tapedButtonFindEmployeeAction(sender: UIButton!) {
        print("Taped button findEmployee")
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case findWorkView.customTextField:
            viewModel.email.send(textField.text)
            resetError(textField)
        default: break
        }
    }
    
    func resetError(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = 0
        self.findWorkView.errorLabel.isHidden = true
    }
}

