import UIKit
import Combine

struct FeedBackViewModelRouting {
    
}

protocol FeedBackViewModelInput {
   
}

protocol FeedBackViewModelOutput {
   
}

typealias FeedBackInfo = FeedBackViewModelInput & FeedBackViewModelOutput

final class FeedBackViewModel: FeedBackInfo {
    
    // MARK: - Private Properties
    
    private var routing: FeedBackViewModelRouting
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Private Subjects
    
    // MARK: - FeedBackViewModelInput
    
    
    // MARK: - FeedBackViewModelOutput
    
    // MARK: - Initialization
    
    init(routing: FeedBackViewModelRouting) {
        self.routing = routing
        configureBindings()
    }
    
    private func configureBindings() {
        
    }
    
}
