import UIKit

final class AddressInfoView: UIView {
    
    lazy private var nameCompanylabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .named(.mapImage)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var addresslabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        nameCompanylabel.text = vacancy?.company
        addresslabel.text = vacancy?.address.descriptionAddress
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "Grey1")!
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    private func setupUI() {
        addSubviews(nameCompanylabel, imageView, addresslabel)
        
        NSLayoutConstraint.activate([
            nameCompanylabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            nameCompanylabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameCompanylabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: nameCompanylabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: nameCompanylabel.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: nameCompanylabel.trailingAnchor, constant: -20),
            
            addresslabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            addresslabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            addresslabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        ])
    }
}
