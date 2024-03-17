import UIKit
import Combine

final class MainCoordinator: Coordinator {
    
    var tabBarController: UITabBarController
    
    var childCoordinators: [Coordinator] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        showMainTabBarViewControllers()
    }
    
    private func showMainTabBarViewControllers() {
        let routingSearch = SearchViewModelRouting()
        let searchViewModel = SearchViewModel(routing: routingSearch)
        let searchViewController = SearchViewController()
        let searchNavController = UINavigationController(rootViewController: searchViewController)
        searchViewController.viewModel = searchViewModel
        
        let routingFavorites = FavoritesViewModelRouting()
        let favoritesViewModel = FavoritesViewModel(routing: routingFavorites)
        let favoritesViewController = FavoritesViewController()
        let favoritesNavController = UINavigationController(rootViewController: favoritesViewController)
        favoritesViewController.viewModel = favoritesViewModel
        
        let routingFeedBack = FeedBackViewModelRouting()
        let feedBackViewModel = FeedBackViewModel(routing: routingFeedBack)
        let feedBackViewController = FeedBackViewController()
        let feedBackNavController = UINavigationController(rootViewController: feedBackViewController)
        feedBackViewController.viewModel = feedBackViewModel
        
        let routingMessages = MessagesViewModelRouting()
        let messagesViewModel = MessagesViewModel(routing: routingMessages)
        let messagesViewController = MessagesViewController()
        let messagesNavController = UINavigationController(rootViewController: messagesViewController)
        messagesViewController.viewModel = messagesViewModel
        
        let routingProfile = ProfileViewModelRouting()
        let profileViewModel = ProfileViewModel(routing: routingProfile)
        let profileViewController = ProfileViewController()
        let profileNavController = UINavigationController(rootViewController: profileViewController)
        profileViewController.viewModel = profileViewModel
        
        searchNavController.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(named: "searchIcon")!, tag: 1)
        favoritesNavController.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(named: "favoriteIcon")!, tag: 2)
        feedBackNavController.tabBarItem = UITabBarItem(title: "Отклики", image: UIImage(named: "feedBackIcon")!, tag: 3)
        messagesNavController.tabBarItem = UITabBarItem(title: "Сообщения", image: UIImage(named: "messageIcon")!, tag: 4)
        profileNavController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profileIcon")!, tag: 5)
        
        tabBarController.setViewControllers([searchNavController, favoritesNavController, feedBackNavController, messagesNavController, profileNavController], animated: true)
    }
}

