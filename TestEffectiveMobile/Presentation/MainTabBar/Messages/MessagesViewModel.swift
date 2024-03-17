import UIKit
import Combine

struct MessagesViewModelRouting {
    
}

protocol MessagesViewModelInput {
   
}

protocol MessagesViewModelOutput {
   
}

typealias MessagesInfo = MessagesViewModelInput & MessagesViewModelOutput

final class MessagesViewModel: MessagesInfo {
    
    // MARK: - Private Properties
    
    private var routing: MessagesViewModelRouting
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Private Subjects
    
    // MARK: - MessagesViewModelInput
    
    
    // MARK: - MessagesViewModelOutput
    
    // MARK: - Initialization
    
    init(routing: MessagesViewModelRouting) {
        self.routing = routing
        configureBindings()
    }
    
    private func configureBindings() {
        
    }
    
}
