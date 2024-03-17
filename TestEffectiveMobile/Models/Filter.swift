import UIKit

struct Filter {
    
    let icon: UIImage
    let title: String
    let isButton: Bool
    
    static func mockFilterModels() -> [Filter] {
        let filter1 = Filter(icon: .named(.vacanciesIcon), title: "Вакансии рядом с вами", isButton: false)
        let filter2 = Filter(icon: .named(.summaryIcon), title: "Поднять рузюме в поиске", isButton: true)
        let filter3 = Filter(icon: .named(.tempWorkIcon), title: "Временная работа и подработка", isButton: false)
        return [filter1, filter2, filter3]
    }
}



