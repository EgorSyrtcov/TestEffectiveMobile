import UIKit

final class JobInfoView: UIView {
    
    lazy var jobTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "UI/UX Designer"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    lazy var incomeLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "Уровень дохода не указан"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var experienceLabel: UILabel = {
        let label = UILabel()
        label.text = "Требуемый опыт: от 1 года до 3 лет"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var employmentTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Полная занятость, полный день"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
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
        backgroundColor = .green
        addSubviews(jobTitleLabel, incomeLevelLabel, experienceLabel, employmentTypeLabel)
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupUI() {
        NSLayoutConstraint.activate([
            jobTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            jobTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            jobTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
            incomeLevelLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 20),
            incomeLevelLabel.leftAnchor.constraint(equalTo: jobTitleLabel.leftAnchor),
            incomeLevelLabel.rightAnchor.constraint(equalTo: jobTitleLabel.rightAnchor),
            
            experienceLabel.topAnchor.constraint(equalTo: incomeLevelLabel.bottomAnchor, constant: 20),
            experienceLabel.leftAnchor.constraint(equalTo: incomeLevelLabel.leftAnchor),
            experienceLabel.rightAnchor.constraint(equalTo: incomeLevelLabel.rightAnchor),
            
            employmentTypeLabel.topAnchor.constraint(equalTo: experienceLabel.bottomAnchor, constant: 10),
            employmentTypeLabel.leftAnchor.constraint(equalTo: experienceLabel.leftAnchor),
            employmentTypeLabel.rightAnchor.constraint(equalTo: experienceLabel.rightAnchor),
            employmentTypeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
