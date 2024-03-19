import UIKit

final class JobInfoView: UIView {
    
    lazy private var jobTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    lazy private var incomeLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy private var experienceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy private var employmentTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    init(frame: CGRect, vacancy: Vacancy?){
        super.init(frame: frame)
        self.setupVacancy(vacancy: vacancy)
        setupViews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupUI()
    }
    
    func setupVacancy(vacancy: Vacancy?) {
        jobTitleLabel.text = vacancy?.title
        incomeLevelLabel.text = vacancy?.salary.full
        experienceLabel.text = "Требуемый опыт: \(vacancy?.experience.text ?? "")"
        employmentTypeLabel.text = vacancy?.formattedSchedules()
    }
    
    private func setupViews() {
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
