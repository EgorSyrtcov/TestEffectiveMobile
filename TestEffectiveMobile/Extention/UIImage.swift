import UIKit

extension UIImage {
    enum AssetName: String {
        case emailIcon
        case closeIcon
        case vacanciesIcon
        case summaryIcon
        case tempWorkIcon
        case searchIcon
        case favoriteIcon
        case feedBackIcon
        case messageIcon
        case profileIcon
        case filterIcon
        case heartFullIcon
        case heartEmptyIcon
        case backIcon
        case lookIcon
        case sharedIcon
    }
    
    static func named(_ name: AssetName) -> UIImage {
        return UIImage(named: name.rawValue)!
    }
}
