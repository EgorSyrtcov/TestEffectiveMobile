import UIKit

final class VacanciesView: UIView {
    
    var tapHeartyButtonAction: (() -> Void)?
    private var isFavoriteButton = false
    
    private let lookPeopleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(named: "Green")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var heartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(heartyButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let professionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let citeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let experienceLabel: UILabel = {
        let label = UILabel()
        label.text = "Опыт от 1 года до 3 лет"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let datePublicLabel: UILabel = {
        let label = UILabel()
        label.text = "Опубликовано 20 февраля"
        label.textAlignment = .left
        label.textColor = UIColor(named: "Grey3")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var replyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Green")
        button.setTitle("Откликнуться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(replyButtonAction), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with vacancies: Vacancy?) {
        guard let vacancies = vacancies else { return }
        lookPeopleLabel.text = vacancies.descriptionLookingNumber()
        professionLabel.text = vacancies.title
        citeLabel.text = vacancies.address.town
        companyLabel.text = vacancies.company
        experienceLabel.text = vacancies.experience.previewText
        datePublicLabel.text = vacancies.descriptionPublishedDate()
        self.isFavoriteButton = vacancies.isFavorite
        heartButton.setImage(
            self.isFavoriteButton ? .named(.heartFullIcon) : .named(.heartEmptyIcon),
            for: .normal
        )
    }
    
    private func setup() {
        self.backgroundColor = UIColor(named: "Grey1")!
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    private func setupUI() {
        self.addSubviews(lookPeopleLabel, heartButton, professionLabel, citeLabel, companyLabel, experienceLabel, datePublicLabel, replyButton)
        
        NSLayoutConstraint.activate([
            
            lookPeopleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            lookPeopleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            lookPeopleLabel.rightAnchor.constraint(equalTo: heartButton.leftAnchor, constant: -60),
            
            heartButton.widthAnchor.constraint(equalToConstant: 25),
            heartButton.heightAnchor.constraint(equalToConstant: 25),
            heartButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            heartButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            professionLabel.topAnchor.constraint(equalTo: lookPeopleLabel.bottomAnchor, constant: 10),
            professionLabel.leftAnchor.constraint(equalTo: lookPeopleLabel.leftAnchor),
            professionLabel.rightAnchor.constraint(equalTo: lookPeopleLabel.rightAnchor),
            
            citeLabel.topAnchor.constraint(equalTo: professionLabel.bottomAnchor, constant: 10),
            citeLabel.leftAnchor.constraint(equalTo: professionLabel.leftAnchor),
            citeLabel.rightAnchor.constraint(equalTo: professionLabel.rightAnchor),
            
            companyLabel.topAnchor.constraint(equalTo: citeLabel.bottomAnchor, constant: 10),
            companyLabel.leftAnchor.constraint(equalTo: citeLabel.leftAnchor),
            companyLabel.rightAnchor.constraint(equalTo: citeLabel.rightAnchor),
            
            experienceLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            experienceLabel.leftAnchor.constraint(equalTo: companyLabel.leftAnchor),
            experienceLabel.rightAnchor.constraint(equalTo: companyLabel.rightAnchor),
            
            datePublicLabel.topAnchor.constraint(equalTo: experienceLabel.bottomAnchor, constant: 10),
            datePublicLabel.leftAnchor.constraint(equalTo: experienceLabel.leftAnchor),
            datePublicLabel.rightAnchor.constraint(equalTo: experienceLabel.rightAnchor),
            datePublicLabel.bottomAnchor.constraint(equalTo: replyButton.topAnchor, constant: -10),
            
            replyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            replyButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            replyButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            replyButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    //MARK: Actions
    
    @objc func replyButtonAction(sender: UIButton!) {
        print("Нажата кнопка Откликнуться")
    }
    
    @objc func heartyButtonAction(sender: UIButton!) {
        self.isFavoriteButton = !isFavoriteButton
        
        heartButton.setImage(
           isFavoriteButton ? .named(.heartFullIcon) : .named(.heartEmptyIcon),
            for: .normal
        )
        tapHeartyButtonAction?()
    }
}
