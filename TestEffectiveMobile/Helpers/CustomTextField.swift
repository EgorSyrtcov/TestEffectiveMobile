import UIKit

class CustomTextField: UITextField {

    let iconImageView = UIImageView()
    let leftIconImage: UIImage
    let clearButtonImage: UIImage
    let clearButton = UIButton(type: .custom)
    
    init(frame: CGRect, leftIconImage: UIImage, clearButtonImage: UIImage) {
        self.leftIconImage = leftIconImage
        self.clearButtonImage = clearButtonImage
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Настройка иконки
        iconImageView.image = leftIconImage
        iconImageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        leftView = iconImageView
        leftViewMode = .always

        // Настройка кнопки очистки
        clearButton.setImage(clearButtonImage, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        rightView = clearButton
        rightViewMode = .whileEditing
        
        // Наблюдатель за свойством 'text'
        self.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        textDidChange()
        return result
    }

    @objc func clearText() {
        text = ""
        textDidChange()
    }
    
    @objc func textDidChange() {
        if let text = self.text, !text.isEmpty {
            // Если текстовое поле не пустое, скрываем иконку электронной почты и показываем кнопку очистки
            leftView = nil
            rightViewMode = .always
        } else {
            // Если текстовое поле пустое, показываем иконку электронной почты и скрываем кнопку очистки
            leftView = iconImageView
            rightViewMode = .never
        }
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += 10 // Отступ слева
        return textRect
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= 10 // Отступ справа
        return textRect
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.textRect(forBounds: bounds)
        if leftView != nil {
            // Если иконка видна, устанавливаем отступ
            textRect.origin.x += 10
        } else {
            // Если иконка скрыта, добавляем отступ слева
            textRect.origin.x += 10
            // Если иконка скрыта, добавляем отступ справа
            textRect.size.width -= 25
        }
        return textRect
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        return self.rightViewRect(forBounds: bounds)
    }
}
