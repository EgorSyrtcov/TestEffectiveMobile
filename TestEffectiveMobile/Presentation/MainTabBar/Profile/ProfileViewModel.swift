import UIKit
import Combine

struct ProfileViewModelRouting {
    
}

protocol ProfileViewModelInput {
   
}

protocol ProfileViewModelOutput {
   
}

typealias ProfileInfo = ProfileViewModelInput & ProfileViewModelOutput

final class ProfileViewModel: ProfileInfo {
    
    // MARK: - Private Properties
    
    private var routing: ProfileViewModelRouting
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Private Subjects
    
    // MARK: - ProfileViewModelInput
    
    
    // MARK: - ProfileViewModelOutput
    
    // MARK: - Initialization
    
    init(routing: ProfileViewModelRouting) {
        self.routing = routing
        configureBindings()
    }
    
    private func configureBindings() {
        
    }
    
}
