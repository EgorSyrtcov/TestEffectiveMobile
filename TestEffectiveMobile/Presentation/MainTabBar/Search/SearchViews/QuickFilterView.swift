import UIKit

final class QuickFilterView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var summaryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Поднять", for: .normal)
        button.setTitleColor(UIColor(named: "Green"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(pickUpButtonAction), for: .touchUpInside)
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

    func update(with filter: Filter) {
        imageView.image = filter.icon
        titleLabel.text = filter.title
        summaryButton.isHidden = filter.isButton ? false : true
    }

    private func setup() {
        self.backgroundColor = UIColor(named: "Grey1")!
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    private func setupUI() {
        self.addSubviews(imageView, titleLabel, summaryButton)
        
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalToConstant: 32),
            imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
            summaryButton.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            summaryButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            summaryButton.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
        ])
    }
    
    //MARK: Actions
    
    @objc func pickUpButtonAction(sender: UIButton!) {
        print("Нажата кнопка Поднять")
    }
}
