import UIKit
import Combine

final class AppCoordinator: Coordinator {
    
    let window: UIWindow
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func start() {
        showRegistrationCoordinator()
    }

    private func showRegistrationCoordinator() {
        let registrationCoordinator = RegistrationCoordinator()
        window.rootViewController = registrationCoordinator.navigationController
        childCoordinators = [registrationCoordinator]
        registrationCoordinator.start()
        registrationCoordinator.flowDidFinishSubject.sink { [weak self] in
            self?.showMainCoordinator()
            self?.removeChildCoordinator(registrationCoordinator)
        }
        .store(in: &cancellables)
    }
    
    private func showMainCoordinator() {
       
    }
    
    private func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
