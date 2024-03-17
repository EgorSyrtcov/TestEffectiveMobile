import UIKit
import Combine

struct FavoritesViewModelRouting {
    
}

protocol FavoritesViewModelInput {
   
}

protocol FavoritesViewModelOutput {
   
}

typealias FavoritesInfo = FavoritesViewModelInput & FavoritesViewModelOutput

final class FavoritesViewModel: FavoritesInfo {
    
    // MARK: - Private Properties
    
    private var routing: FavoritesViewModelRouting
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Private Subjects
    
    // MARK: - FavoritesViewModelInput
    
    
    // MARK: - FavoritesViewModelOutput
    
    // MARK: - Initialization
    
    init(routing: FavoritesViewModelRouting) {
        self.routing = routing
        configureBindings()
    }
    
    private func configureBindings() {
        
    }
    
}
