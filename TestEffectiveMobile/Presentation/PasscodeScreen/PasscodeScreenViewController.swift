import UIKit
import Combine

final class PasscodeViewController: UIViewController {
    
    private let buttons: [[Int]] = [[1,2,3], [4,5,6], [7,8,9], [0]]
    
    lazy var passcodeTitle: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var keyboardStack: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .red
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var codeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var deleteBtn: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "BackButton"), for: .normal)
        //button.addTarget(self, action: #selector(tapBackButtonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: Private
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Public
    var viewModel: PasscodeScreenViewModelInfo!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupKeyPad()
//        setupCodeStack()
//        setupUI()
//        viewModelBinding()
    }
    
    private func viewModelBinding() {
        viewModel.passcodeStatePublisher
            .sink { [weak self] passcodeState in
                self?.passcodeTitle.text = passcodeState.description
            }
            .store(in: &cancellables)
        
        viewModel.enterCodePublisher
            .sink { [weak self] code in
                let tag = code.count + 10
                
                (tag...14).forEach {
                    self?.view.viewWithTag($0)?.backgroundColor = .none
                }
                
                self?.view.viewWithTag(tag)?.backgroundColor = .black
            }
            .store(in: &cancellables)
    }
    
//    private func setupUI() {
//        view.backgroundColor = .white
//        view.addSubviews(passcodeTitle, keyboardStack, deleteBtn, codeStack)
//
//        passcodeTitle.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
//            make.left.equalTo(view.snp.left).offset(50)
//            make.right.equalTo(view.snp.right).offset(-50)
//        }
//
//        keyboardStack.snp.makeConstraints { make in
//            make.left.equalTo(view.snp.left).offset(50)
//            make.right.equalTo(view.snp.right).offset(-50)
//            make.centerX.equalTo(view.snp.centerX)
//            make.centerY.equalTo(view.snp.centerY)
//        }
//
//        deleteBtn.snp.makeConstraints { make in
//            make.bottom.equalTo(keyboardStack.snp.bottom).offset(-19)
//            make.right.equalTo(keyboardStack.snp.right).offset(-38)
//            make.width.equalTo(45)
//            make.height.equalTo(45)
//        }
//
//        codeStack.snp.makeConstraints { make in
//            make.width.equalTo(150)
//            make.top.equalTo(passcodeTitle.snp.bottom).offset(40)
//            make.centerX.equalTo(view.snp.centerX)
//        }
//    }
//
//    private func setupKeyPad() {
//        buttons.forEach {
//            let buttonLine = setHorizontalNumStack(range: $0)
//            keyboardStack.addArrangedSubview(buttonLine)
//        }
//    }
//
//    private func setupCodeStack() {
//        (11...14).forEach {
//            let view = getCodeView(tag: $0)
//            codeStack.addArrangedSubview(view)
//        }
//    }
//
//    private func getHorizontalNumStack() -> UIStackView {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.spacing = 50
//        return stackView
//    }
//
//    private func setHorizontalNumStack(range: [Int]) -> UIStackView {
//        let stack = getHorizontalNumStack()
//        range.forEach {
//            let numButton = UIButton()
//            numButton.tag = $0
//            numButton.addTarget(self, action: #selector(tapEnterCodeButtonAction), for: .touchUpInside)
//            numButton.setTitle("\($0)", for: .normal)
//            numButton.setTitleColor(.blue, for: .normal)
//            numButton.titleLabel?.font = UIFont.systemFont(ofSize: 60, weight: .light)
//            stack.addArrangedSubview(numButton)
//        }
//        return stack
//    }
//
//    private func getCodeView(tag: Int) -> UIView {
//        let view = UIView()
//        view.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        view.layer.cornerRadius = 10
//        view.layer.borderWidth = 2
//        view.tag = tag
//        view.layer.borderColor = UIColor.black.cgColor
//        return view
//    }
//
//    //MARK: Actions
//
//    @objc func tapBackButtonAction(sender: UIButton!) {
//        viewModel.removeLastItemInPasscodeSubject.send()
//    }
//
//    @objc func tapEnterCodeButtonAction(sender: UIButton!) {
//        viewModel.enterPasscodeSubject.send(sender.tag)
//    }
//
}
