import UIKit

final class FindEmployeeView: UIView {
    
    lazy var findEmployeeLabel: UILabel = {
        let label = UILabel()
        label.text = "Поиск сотрудников"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy var vacancyLabel: UILabel = {
        let label = UILabel()
        label.text = "Размещение вакансии и доступ к базе резюме"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Я ищу сотрудников", for: .normal)
        button.backgroundColor = UIColor(named: "Green")
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 15
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
        addSubviews(findEmployeeLabel, vacancyLabel, continueButton)
        
        backgroundColor = UIColor(named: "Grey1")
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        clipsToBounds = true
    }

    private func setupUI() {
        NSLayoutConstraint.activate([
            findEmployeeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            findEmployeeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            findEmployeeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            vacancyLabel.topAnchor.constraint(equalTo: findEmployeeLabel.bottomAnchor, constant: 16),
            vacancyLabel.leftAnchor.constraint(equalTo: findEmployeeLabel.leftAnchor),
            vacancyLabel.rightAnchor.constraint(equalTo: findEmployeeLabel.rightAnchor),
            
            continueButton.topAnchor.constraint(equalTo: vacancyLabel.bottomAnchor, constant: 20),
            continueButton.leftAnchor.constraint(equalTo: vacancyLabel.leftAnchor),
            continueButton.rightAnchor.constraint(equalTo: vacancyLabel.rightAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}

