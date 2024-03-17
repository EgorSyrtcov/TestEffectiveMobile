import UIKit
import Combine

final class PasscodeViewController: UIViewController {
    
    lazy var emailTitle: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = "Отправили код на email"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var discriptionTitle: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = "Напишите его, чтобы подтвердить, что это вы, а не кто то другой входит в личный кабинет"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var codeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    // MARK: Private
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Public
    var viewModel: PasscodeScreenViewModelInfo!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModelBinding()
        setupCodeStack()
    }
    
    private func viewModelBinding() {
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
        view.backgroundColor = .black
        view.addSubviews(emailTitle, discriptionTitle, codeStack, continueButton)
        
        NSLayoutConstraint.activate([
            emailTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            emailTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            
            discriptionTitle.topAnchor.constraint(equalTo: emailTitle.bottomAnchor, constant: 20),
            discriptionTitle.leftAnchor.constraint(equalTo: emailTitle.leftAnchor),
            discriptionTitle.rightAnchor.constraint(equalTo: emailTitle.rightAnchor),

            codeStack.leftAnchor.constraint(equalTo: emailTitle.leftAnchor),
            codeStack.topAnchor.constraint(equalTo: discriptionTitle.bottomAnchor, constant: 20),
            
            continueButton.topAnchor.constraint(equalTo: codeStack.bottomAnchor, constant: 20),
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            continueButton.heightAnchor.constraint(equalToConstant: 48),
            
        ])
    }

    private func setupCodeStack() {
        (0...3).forEach {
            let textField = getCodeView(tag: $0)
            codeStack.addArrangedSubview(textField)
            if $0 == 0 { textField.becomeFirstResponder()}
        }
    }

    private func getCodeView(tag: Int) -> UITextField {
        let textField = UITextField()
        textField.widthAnchor.constraint(equalToConstant: 48).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        textField.layer.cornerRadius = 8
        textField.tag = tag
        textField.backgroundColor = UIColor(named: "Grey2")
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        if tag != 0 {
            textField.attributedPlaceholder = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Grey3")!])
            }
        return textField
    }

    //MARK: Actions
    
    @objc func continueButtonAction(sender: UIButton!) {
        viewModel.nextScreenDidTapSubject.send()
    }

}

extension PasscodeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // Если введена одна цифра, переходим к следующему текстовому полю
        if updatedText.count == 1 {
            textField.text = updatedText
            if let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField {
                nextTextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder() // Убираем фокус с последнего текстового поля
                
                if textField.tag == 3 { viewModel.nextButtonStateSubject.send(true) }
            }
        }
        
        // Разрешаем изменение, только если обновленный текст будет пустым
        return updatedText.isEmpty
    }
}
