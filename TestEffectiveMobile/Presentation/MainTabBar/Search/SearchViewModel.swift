import UIKit
import Combine

struct SearchViewModelRouting {
    let showDetailScreenSubject = PassthroughSubject<Vacancy, Never>()
}

protocol SearchViewModelInput {
    var heartButtonDidTapSubject: PassthroughSubject<Vacancy?, Never> { get }
    var didTapCellVacancySubject: PassthroughSubject<Vacancy?, Never> { get }
}

protocol SearchViewModelOutput {
    var updateOffersPublisher: AnyPublisher<Offers?, Never> { get }
}

typealias SearchInfo = SearchViewModelInput & SearchViewModelOutput

final class SearchViewModel: SearchInfo {
    
    // MARK: - Private Properties
    
    private var routing: SearchViewModelRouting
    private var cancellables: Set<AnyCancellable> = []
    private let service = Service()
    private let localService = LocalService()
    
    // MARK: - Private Subjects
    
    private let offersSubject = PassthroughSubject<Offers?, Never>()
    
    // MARK: - SearchViewModelInput
    
    let heartButtonDidTapSubject = PassthroughSubject<Vacancy?, Never>()
    let didTapCellVacancySubject = PassthroughSubject<Vacancy?, Never>()
    
    // MARK: - SearchViewModelOutput
    
    var updateOffersPublisher: AnyPublisher<Offers?, Never> {
        offersSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Initialization
    
    init(routing: SearchViewModelRouting) {
        self.routing = routing
        configureBindings()
    }
    
    private func configureBindings() {
        serviceRequest()
        
        heartButtonDidTapSubject
            .sink { [weak self] vacancyModel in
                guard let vacancy = vacancyModel else { return }
                self?.localService.updateVacancy(vacancy: vacancy)
            }
            .store(in: &cancellables)
        
        didTapCellVacancySubject
            .sink { [weak self] vacancyModel in
                guard let vacancy = vacancyModel else { return }
                self?.routing.showDetailScreenSubject.send(vacancy)
            }
            .store(in: &cancellables)
        
        
    }
    
    private func serviceRequest() {
        Task {
            do {
                let offers = try await requestOffers()
                self.offersSubject.send(offers)
            } catch {
                print("ERROR: \(error)")
            }
        }
    }

    private func requestOffers() async throws -> Offers? {
        return try await service.execute(.getOffersRequest(), expecting: Offers.self)
    }
    
}
