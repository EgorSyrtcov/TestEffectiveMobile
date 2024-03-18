import UIKit

final class SearchVacanciesCell<T: UIView>: UITableViewCell {
    
    let containerView: T
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.containerView = T(frame: .zero)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(containerView)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margins = UIEdgeInsets(top: 2, left: 2, bottom: 20, right: 2)
        contentView.frame = contentView.frame.inset(by: margins)
    }
}
