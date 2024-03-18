import UIKit
import Combine

struct DetailViewModelRouting {
    let backButtonDidTapSubject = PassthroughSubject<Void, Never>()
}

protocol DetailViewModelInput {
    var backButtonDidTapSubject: PassthroughSubject<Void, Never> { get }
}

protocol DetailViewModelOutput {
   
}

typealias DetailInfo = DetailViewModelInput & DetailViewModelOutput

final class DetailViewModel: DetailInfo {
    
    // MARK: - Private Properties
    
    private var routing: DetailViewModelRouting
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Private Subjects
    
    
    // MARK: - LoginViewModelInput
    
    let backButtonDidTapSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - LoginViewModelOutput
    
    
    // MARK: - Initialization
    
    init(routing: DetailViewModelRouting) {
        self.routing = routing
        configureBindings()
    }
    
    private func configureBindings() {
        backButtonDidTapSubject
            .sink { [weak self] _ in
                self?.routing.backButtonDidTapSubject.send()
            }
            .store(in: &cancellables)
    }
}
