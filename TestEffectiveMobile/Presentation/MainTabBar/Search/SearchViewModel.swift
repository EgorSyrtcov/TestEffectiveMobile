import UIKit
import Combine

struct SearchViewModelRouting {
    
}

protocol SearchViewModelInput {
   
}

protocol SearchViewModelOutput {
   
}

typealias SearchInfo = SearchViewModelInput & SearchViewModelOutput

final class SearchViewModel: SearchInfo {
    
    // MARK: - Private Properties
    
    private var routing: SearchViewModelRouting
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Private Subjects
    
    // MARK: - SearchViewModelInput
    
    
    // MARK: - SearchViewModelOutput
    
    // MARK: - Initialization
    
    init(routing: SearchViewModelRouting) {
        self.routing = routing
        configureBindings()
    }
    
    private func configureBindings() {
        
    }
    
}
