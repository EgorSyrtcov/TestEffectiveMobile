import Foundation

// MARK: - Offers
struct Offers: Codable {
    let offers: [Offer]
    let vacancies: [Vacancy]
}

// MARK: - Offer
struct Offer: Codable {
    let id: String?
    let title: String
    let link: String
    let button: Button?
}

// MARK: - Button
struct Button: Codable {
    let text: String
}

// MARK: - Vacancy
struct Vacancy: Codable {
    let id: String
    let lookingNumber: Int?
    let title: String
    let address: Address
    let company: String
    let experience: Experience
    let publishedDate: String
    let isFavorite: Bool
    let salary: Salary
    let schedules: [String]
    let appliedNumber: Int?
    let description: String?
    let responsibilities: String
    let questions: [String]
    
    func descriptionLookingNumber() -> String {
        guard let lookingNumber = lookingNumber else { return "" }
        let ending: String
        switch lookingNumber % 100 {
        case 11...14:
            ending = "человек"
        default:
            switch lookingNumber % 10 {
            case 1:
                ending = "человек"
            case 2...4:
                ending = "человека"
            default:
                ending = "человек"
            }
        }
        return "Сейчас просматривают \(lookingNumber) \(ending)"
    }
    
    // Функция для форматирования типа занятости
    func formattedSchedules() -> String {
        guard !schedules.isEmpty else { return "Тип занятости не указан" }
        
        let formattedSchedules = schedules.map { schedule -> String in
            let words = schedule.lowercased().split(separator: " ").map(String.init)
            let capitalizedWords = words.enumerated().map { index, word -> String in
                if index == 0 || words[index - 1].last == "," {
                    return word.capitalized
                } else {
                    return word
                }
            }
            return capitalizedWords.joined(separator: " ")
        }.joined(separator: ", ")
        
        return formattedSchedules
    }
    
    // Функция для форматирования количества откликов
    func formattedAppliedNumber(_ appliedNumber: Int) -> String {
        let number = appliedNumber % 100
        let remainder = number % 10
        
        let ending: String
        if (number >= 11 && number <= 19) {
            ending = "человек уже откликнулось"
        } else if (remainder == 1) {
            ending = "человек уже откликнулся"
        } else if (remainder >= 2 && remainder <= 4) {
            ending = "человека уже откликнулись"
        } else {
            ending = "человек откликнулось"
        }
        
        return "\(appliedNumber) \(ending)"
    }
    
    func descriptionPublishedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Измените это на формат вашей даты
        guard let date = dateFormatter.date(from: publishedDate) else { return "" }
        dateFormatter.dateFormat = "d MMMM"
        let dateString = dateFormatter.string(from: date)
        let components = dateString.components(separatedBy: " ")
        guard let day = components.first, let month = components.last else { return "" }
        return "Опубликовано \(day) \(declineMonthName(month, day: Int(day)!))"
    }
    
    private func declineMonthName(_ month: String, day: Int) -> String {
        let monthDeclensions: [String: [String]] = [
            "январь": ["января", "января", "января"],
            "февраль": ["февраля", "февраля", "февраля"],
            // Добавьте остальные месяцы
        ]
        let lastDigit = day % 10
        var declensionIndex = 2
        if lastDigit == 1 {
            declensionIndex = 0
        } else if lastDigit >= 2 && lastDigit <= 4 {
            declensionIndex = 1
        }
        return monthDeclensions[month]?[declensionIndex] ?? month
    }
    
    // MARK: - Address
    struct Address: Codable {
        let town, street, house: String
        
        var descriptionAddress: String {
                return "\(town), \(street), \(house)"
            }
    }
    
    // MARK: - Experience
    struct Experience: Codable {
        let previewText, text: String
    }
    
    // MARK: - Salary
    struct Salary: Codable {
        let full: String
        let short: String?
    }
}
