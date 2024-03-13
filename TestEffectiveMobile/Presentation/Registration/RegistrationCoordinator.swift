import UIKit
import Combine

final class RegistrationCoordinator: Coordinator {
    
    var navigationController = UINavigationController()
    
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
    }
}
