import UIKit

final class DescriptionInfoView: UIView {
    
    private var questions = [String]()
    
    lazy private var descriptionlabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var yourTasklabel: UILabel = {
        let label = UILabel()
        label.text = "Ваши задачи"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var yourTaskDescritionlabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var tasklabel: UILabel = {
        let label = UILabel()
        label.text = "Задайте вопросы работадателю"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var requestTasklabel: UILabel = {
        let label = UILabel()
        label.text = "Он получит его с откликом на вакансию"
        label.textColor = UIColor(named: "Grey3")
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var questionsView: QuestionsView = {
        let questionsView = QuestionsView()
        questionsView.addLabels(from: questions)
        questionsView.translatesAutoresizingMaskIntoConstraints = false
        questionsView.setupConstraints()
        return questionsView
    }()
    
    init(frame: CGRect, vacancy: Vacancy?) {
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
        questions = vacancy?.questions ?? []
        descriptionlabel.text = vacancy?.description
        yourTaskDescritionlabel.text = vacancy?.description
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupUI() {
        addSubviews(descriptionlabel, yourTasklabel, yourTaskDescritionlabel, tasklabel, requestTasklabel, questionsView)
        
        NSLayoutConstraint.activate([
            descriptionlabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            descriptionlabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionlabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            yourTasklabel.topAnchor.constraint(equalTo: descriptionlabel.bottomAnchor, constant: 10),
            yourTasklabel.leadingAnchor.constraint(equalTo: descriptionlabel.leadingAnchor),
            yourTasklabel.trailingAnchor.constraint(equalTo: descriptionlabel.trailingAnchor),
            
            yourTaskDescritionlabel.topAnchor.constraint(equalTo: yourTasklabel.bottomAnchor, constant: 10),
            yourTaskDescritionlabel.leadingAnchor.constraint(equalTo: yourTasklabel.leadingAnchor),
            yourTaskDescritionlabel.trailingAnchor.constraint(equalTo: yourTasklabel.trailingAnchor),
            
            tasklabel.topAnchor.constraint(equalTo: yourTaskDescritionlabel.bottomAnchor, constant: 30),
            tasklabel.leadingAnchor.constraint(equalTo: yourTaskDescritionlabel.leadingAnchor),
            tasklabel.trailingAnchor.constraint(equalTo: yourTaskDescritionlabel.trailingAnchor),
            
            requestTasklabel.topAnchor.constraint(equalTo: tasklabel.bottomAnchor, constant: 10),
            requestTasklabel.leadingAnchor.constraint(equalTo: tasklabel.leadingAnchor),
            requestTasklabel.trailingAnchor.constraint(equalTo: tasklabel.trailingAnchor),
            
            questionsView.topAnchor.constraint(equalTo: requestTasklabel.topAnchor, constant: 20),
            questionsView.leadingAnchor.constraint(equalTo: requestTasklabel.leadingAnchor),
            questionsView.trailingAnchor.constraint(equalTo: requestTasklabel.trailingAnchor),
            questionsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    //MARK: Actions
    
    @objc func replyButtonAction(sender: UIButton!) {
        print("Нажата кнопка Откликнуться")
    }
}

