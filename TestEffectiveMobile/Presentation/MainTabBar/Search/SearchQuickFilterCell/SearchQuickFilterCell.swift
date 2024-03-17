import UIKit

final class SearchQuickFilterCell<T: UIView>: UICollectionViewCell {
    
    let containerView: T
    
    override init(frame: CGRect) {
        self.containerView = T(frame: .zero)
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
}

