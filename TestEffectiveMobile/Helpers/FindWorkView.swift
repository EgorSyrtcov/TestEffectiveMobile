import UIKit

final class FindWorkView: UIView {
    
    lazy var findWorkLabel: UILabel = {
        let label = UILabel()
        label.text = "Поиск работы"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy var customTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero,
                                        leftIconImage: .named(.emailIcon),
                                        clearButtonImage: .named(.closeIcon))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: "Электронная почта или телефон", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.backgroundColor = UIColor(named: "Grey2")
        textField.keyboardType = .default
        textField.returnKeyType = .next
        textField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textField.layer.cornerRadius = 8
        textField.textColor = UIColor(named: "Grey4")
        return textField
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы ввели неверный е-mail"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.backgroundColor = UIColor(named: "DarkBlue")
        button.setTitleColor(UIColor(named: "Gray4"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.alpha = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    lazy var enterWithPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти с паролем", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(UIColor(named: "Blue"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupUI()
    }
    
    private func setupViews() {
        addSubviews(findWorkLabel, customTextField, errorLabel, continueButton, enterWithPasswordButton)
        
        backgroundColor = UIColor(named: "Grey1")
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        clipsToBounds = true
    }

    private func setupUI() {
        NSLayoutConstraint.activate([
            findWorkLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            findWorkLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            findWorkLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            customTextField.topAnchor.constraint(equalTo: findWorkLabel.bottomAnchor, constant: 16),
            customTextField.leftAnchor.constraint(equalTo: findWorkLabel.leftAnchor),
            customTextField.rightAnchor.constraint(equalTo: findWorkLabel.rightAnchor),
            customTextField.heightAnchor.constraint(equalToConstant: 40),
            
            errorLabel.topAnchor.constraint(equalTo: customTextField.bottomAnchor, constant: 5),
            errorLabel.leftAnchor.constraint(equalTo: customTextField.leftAnchor),
            errorLabel.rightAnchor.constraint(equalTo: customTextField.rightAnchor),
            errorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            continueButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 5),
            continueButton.leftAnchor.constraint(equalTo: errorLabel.leftAnchor),
            continueButton.widthAnchor.constraint(equalTo: errorLabel.widthAnchor, multiplier: 0.4),
            
            enterWithPasswordButton.heightAnchor.constraint(equalToConstant: 40),
            enterWithPasswordButton.topAnchor.constraint(equalTo: continueButton.topAnchor),
            enterWithPasswordButton.rightAnchor.constraint(equalTo: customTextField.rightAnchor),
            enterWithPasswordButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
        ])
    }
}
