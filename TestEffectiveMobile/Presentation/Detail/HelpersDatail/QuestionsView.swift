import UIKit

final class QuestionsView: UIView {
    
    private var labels: [UILabel] = []
    
    func addLabels(from array: [String]) {
        for text in array {
            let label = UILabel()
            label.text = "   " + text // Добавляем отступ слева
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.backgroundColor = .gray
            label.layer.cornerRadius = 10
            label.clipsToBounds = true
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)
            labels.append(label)
        }
    }
    
    func setupConstraints() {
        var previousLabel: UILabel?
        for label in labels {
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: leadingAnchor),
                label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height + 10),
                label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width + 10),
                previousLabel == nil ? label.topAnchor.constraint(equalTo: topAnchor, constant: 10) : label.topAnchor.constraint(equalTo: previousLabel!.bottomAnchor, constant: 10)
            ])
            previousLabel = label
        }
        
        if let lastLabel = labels.last {
              lastLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
          }
    }
}
