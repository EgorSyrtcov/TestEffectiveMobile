import Foundation

private enum SessionUserDefaultKey: String {
    case notification = "vacancies"
    var key: String { return rawValue }
}

final class LocalService {
 
    private let userDefaults = UserDefaults.standard
    
    var vacancies: [Vacancy] {
        get {
            guard let data = userDefaults.value(forKey: SessionUserDefaultKey.notification.key) as? Data,
                  let items = try? PropertyListDecoder().decode([Vacancy].self, from: data) else { return [] }
            return items
        }
        
        set {
            guard let data = try? PropertyListEncoder().encode(newValue) else { return }
            userDefaults.set(data, forKey: SessionUserDefaultKey.notification.key)
        }
    }
    
    func updateVacancy(vacancy: Vacancy) {
        if let index = vacancies.firstIndex(where: { $0.id == vacancy.id }) {
            // Вакансия с таким id уже существует, удаляем ее
            vacancies.remove(at: index)
        } else {
            // Вакансии с таким id нет, добавляем ее
            vacancies.append(vacancy)
        }
    }
}
