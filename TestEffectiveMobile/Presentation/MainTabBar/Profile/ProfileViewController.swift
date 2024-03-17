import UIKit
import Combine

final class ProfileViewController: UIViewController {
    
    // MARK: Private
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Public
    var viewModel: ProfileInfo!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        viewModelBinding()
    }
    
    private func setup() {
        view.backgroundColor = .black
    }
    
    private func viewModelBinding() {
        
    }
}
