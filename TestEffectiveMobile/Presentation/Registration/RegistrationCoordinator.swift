import UIKit
import Combine

final class RegistrationCoordinator: Coordinator {
    
    let navigationController = UINavigationController()
    
    let flowDidFinishSubject = PassthroughSubject<Void, Never>()
    private var cancellables: Set<AnyCancellable> = []
    
    func start() {
        showLoginViewController()
    }
    
    private func showLoginViewController() {
        let routing = LoginViewModelRouting()
        let loginViewModel = LoginViewModel(routing: routing)
        
        let loginViewController = LoginViewController()
        loginViewController.viewModel = loginViewModel
        navigationController.setViewControllers([loginViewController], animated: false)
        
        routing.showPasswordScreenSubject
            .sink { [weak self] _ in
                self?.showPasscodeCoordinator()
            }
            .store(in: &cancellables)
    }
    
    private func showPasscodeCoordinator() {
        let routing = PasscodeScreenViewModelRouting()
        let passcodeViewModel = PasscodeScreenViewModel(routing: routing)
        let passcodeViewController = PasscodeViewController()
        passcodeViewController.viewModel = passcodeViewModel
        navigationController.pushViewController(passcodeViewController, animated: true)
        
        routing.showMailScreenSubject
            .sink { [weak self] _ in
                self?.flowDidFinishSubject.send()
            }
            .store(in: &cancellables)
    }
}
