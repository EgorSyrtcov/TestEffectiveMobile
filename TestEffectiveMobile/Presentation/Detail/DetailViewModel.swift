import UIKit
import Combine

struct DetailViewModelRouting {
    let backButtonDidTapSubject = PassthroughSubject<Void, Never>()
}

protocol DetailViewModelInput {
    var backButtonDidTapSubject: PassthroughSubject<Void, Never> { get }
}

protocol DetailViewModelOutput {
    var updateVacancyPublisher: AnyPublisher<Vacancy?, Never> { get }
}

typealias DetailInfo = DetailViewModelInput & DetailViewModelOutput

final class DetailViewModel: DetailInfo {
    
    // MARK: - Private Properties
    
    private var routing: DetailViewModelRouting
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Private Subjects
    private let offersSubject = CurrentValueSubject<Vacancy?, Never>(nil)
    
    // MARK: - LoginViewModelInput
    
    let backButtonDidTapSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - LoginViewModelOutput
    
    var updateVacancyPublisher: AnyPublisher<Vacancy?, Never> {
        offersSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Initialization
    
    init(routing: DetailViewModelRouting, vacancy: Vacancy) {
        self.routing = routing
        offersSubject.send(vacancy)
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
