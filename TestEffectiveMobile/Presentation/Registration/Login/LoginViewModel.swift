import UIKit
import Combine

struct LoginViewModelRouting {
    
}

protocol LoginViewModelInput {
    var email: CurrentValueSubject<String?, Never> { get set }
    var nextButtonDidTapSubject: PassthroughSubject<Void, Never> { get }
}

protocol LoginViewModelOutput {
    var nextButtonStatePublisher: AnyPublisher<Bool, Never> { get }
    var errorPublisher: AnyPublisher<(title: String?, subtitle: String?), Never> { get }
}

typealias LoginInfo = LoginViewModelInput & LoginViewModelOutput

final class LoginViewModel: LoginInfo {
    
    // MARK: - Private Properties
    
    private var routing: LoginViewModelRouting
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Private Subjects
    
    private let errorSubject = PassthroughSubject<(title: String?, subtitle: String?), Never>()
    
    // MARK: - LoginViewModelInput
    
    var email = CurrentValueSubject<String?, Never>("")
    let nextButtonDidTapSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - LoginViewModelOutput
    
    var nextButtonStatePublisher: AnyPublisher<Bool, Never> {
        return
            email.map { $0?.isEmpty == false }
            .eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<(title: String?, subtitle: String?), Never> {
        errorSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Initialization
    
    init(routing: LoginViewModelRouting) {
        self.routing = routing
        configureBindings()
    }
    
    private func configureBindings() {
        nextButtonDidTapSubject
            .sink { [weak self] _ in
                guard
                    self?.loginAndPasswordValidate() == true
                else {
                    self?.errorSubject.send((title: "Email is invalid or password is less than 6 characters", subtitle: nil))
                    return
                }
                print("GO to MAIN Screen")
            }
            .store(in: &cancellables)
    }
    
    private func loginAndPasswordValidate() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email.value)
    }
    
}
