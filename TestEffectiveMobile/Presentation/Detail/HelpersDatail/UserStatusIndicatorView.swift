import UIKit

final class UserStatusIndicatorView: UIView {
    
    lazy private var respondedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DarkGreen")
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var respondedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy private var watchingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DarkGreen")
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var watchingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .named(.profileFullIcon)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let lookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .named(.lookFullIcon)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        respondedLabel.text = vacancy?.formattedAppliedNumber(vacancy?.appliedNumber ?? 0)
        watchingLabel.text = vacancy?.descriptionLookingNumber()
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupUI() {
        addSubviews(respondedView, watchingView)
        respondedView.addSubviews(respondedLabel,profileImage)
        watchingView.addSubviews(watchingLabel,lookImage)
        
        NSLayoutConstraint.activate([
            
            respondedView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            respondedView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            respondedView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            respondedView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.46),
            
            watchingView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            watchingView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            watchingView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            watchingView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.46),
            
            profileImage.topAnchor.constraint(equalTo: respondedView.topAnchor, constant: 5),
            profileImage.rightAnchor.constraint(equalTo: respondedView.rightAnchor, constant: -10),
            profileImage.widthAnchor.constraint(equalToConstant: 20),
            profileImage.heightAnchor.constraint(equalToConstant: 20),
            
            respondedLabel.topAnchor.constraint(equalTo: respondedView.topAnchor, constant: 10),
            respondedLabel.bottomAnchor.constraint(equalTo: respondedView.bottomAnchor, constant: -10),
            respondedLabel.leadingAnchor.constraint(equalTo: respondedView.leadingAnchor, constant: 10),
            respondedLabel.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: -5),
            
            lookImage.topAnchor.constraint(equalTo: watchingView.topAnchor, constant: 5),
            lookImage.rightAnchor.constraint(equalTo: watchingView.rightAnchor, constant: -10),
            lookImage.widthAnchor.constraint(equalToConstant: 20),
            lookImage.heightAnchor.constraint(equalToConstant: 20),
            
            watchingLabel.topAnchor.constraint(equalTo: watchingView.topAnchor, constant: 10),
            watchingLabel.bottomAnchor.constraint(equalTo: watchingView.bottomAnchor, constant: -10),
            watchingLabel.leadingAnchor.constraint(equalTo: watchingView.leadingAnchor, constant: 10),
            watchingLabel.trailingAnchor.constraint(equalTo: lookImage.trailingAnchor, constant: -5),
        ])
    }
}
