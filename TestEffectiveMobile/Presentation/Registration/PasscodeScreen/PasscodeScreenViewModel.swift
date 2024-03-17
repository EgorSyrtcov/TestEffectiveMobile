import UIKit
import Combine

struct PasscodeScreenViewModelRouting {
    let showMailScreenSubject = PassthroughSubject<Void, Never>()
}

protocol PasscodeScreenViewModelInput {
    var nextButtonStateSubject: PassthroughSubject<Bool, Never> { get }
    var nextScreenDidTapSubject: PassthroughSubject<Void, Never> { get }
}

protocol PasscodeScreenViewModelOutput {
    var nextButtonStatePublisher: AnyPublisher<Bool, Never> { get }
}

typealias PasscodeScreenViewModelInfo = PasscodeScreenViewModelInput & PasscodeScreenViewModelOutput

final class PasscodeScreenViewModel: PasscodeScreenViewModelInfo {
    
    // MARK: - Private Properties
    
    private var routing: PasscodeScreenViewModelRouting
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Private Subjects
    
    private let passcodeSubject = CurrentValueSubject<[Int], Never>([])
    
    // MARK: - PasscodeViewModelInput
    
    let nextButtonStateSubject = PassthroughSubject<Bool, Never>()
    let nextScreenDidTapSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - PasscodeViewModelOutput
    var nextButtonStatePublisher: AnyPublisher<Bool, Never> {
        nextButtonStateSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Initialization
    
    init(routing: PasscodeScreenViewModelRouting) {
        self.routing = routing
        configureBindings()
    }
    
    private func configureBindings() {
        nextScreenDidTapSubject
            .sink { [weak self] _ in
                self?.routing.showMailScreenSubject.send()
            }
            .store(in: &cancellables)
    }
}


