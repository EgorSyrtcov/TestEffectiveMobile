import UIKit
import Combine

enum PasscodeState: String {
    case inputPasscode
    case wrongPasscode
    case setNewPasscode
    case repeatPasscode
    case codeMisMatch
    
    var description: String {
        switch self {
        case .inputPasscode:
            return "Введите код"
        case .wrongPasscode:
            return "Неверный код"
        case .setNewPasscode:
            return "Установите код"
        case .repeatPasscode:
            return "Повторите код"
        case .codeMisMatch:
            return "Коды не совпадают"
        }
    }
}

struct PasscodeScreenViewModelRouting {
    
}

protocol PasscodeScreenViewModelInput {
    var enterPasscodeSubject: PassthroughSubject<Int, Never> { get }
    var removeLastItemInPasscodeSubject: PassthroughSubject<Void, Never> { get }
}

protocol PasscodeScreenViewModelOutput {
    var passcodeStatePublisher: AnyPublisher<PasscodeState, Never> { get }
    var enterCodePublisher: AnyPublisher<[Int], Never> { get }
}

typealias PasscodeScreenViewModelInfo = PasscodeScreenViewModelInput & PasscodeScreenViewModelOutput

final class PasscodeScreenViewModel: PasscodeScreenViewModelInfo {
    
    // MARK: - Private Properties
    
    private var routing: PasscodeScreenViewModelRouting
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Private Subjects
    
    private let passcodeSubject = CurrentValueSubject<[Int], Never>([])
    private let currentPasscodeStateSubject = CurrentValueSubject<PasscodeState, Never>(.inputPasscode)
    
    // MARK: - PasscodeViewModelInput
    
    let enterPasscodeSubject = PassthroughSubject<Int, Never>()
    let removeLastItemInPasscodeSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - PasscodeViewModelOutput
    
    var passcodeStatePublisher: AnyPublisher<PasscodeState, Never> {
        currentPasscodeStateSubject
            .eraseToAnyPublisher()
    }
    
    var enterCodePublisher: AnyPublisher<[Int], Never> {
        passcodeSubject
            .eraseToAnyPublisher()
    }
    
    // MARK: - Initialization
    
    init(routing: PasscodeScreenViewModelRouting) {
        self.routing = routing
        configureBindings()
    }
    
    private func configureBindings() {
        
        passcodeSubject.sink { [weak self] num in
            if num.count == 4 {
                self?.currentPasscodeStateSubject.send(.repeatPasscode)
            } else {
                self?.currentPasscodeStateSubject.send(.inputPasscode)
            }
        }
        .store(in: &cancellables)
        
        enterPasscodeSubject.sink { [weak self] num in
            if self?.passcodeSubject.value.count ?? 0 < 4 {
                self?.passcodeSubject.value.append(num)
            }
        }
        .store(in: &cancellables)
        
        removeLastItemInPasscodeSubject.sink { [weak self] _ in
            if !(self?.passcodeSubject.value.isEmpty ?? true) {
                self?.passcodeSubject.value.removeLast()
            }
        }
        .store(in: &cancellables)
        
        
    }
}


