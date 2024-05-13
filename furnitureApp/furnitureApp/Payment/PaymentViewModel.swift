
import Foundation

final class PaymentViewModel: ObservableObject {
    @Published var cardName = "Your Name"
    @Published var cardNumber = "0000 0000 0000 0000"
    @Published var currentYear = "Year"
    @Published var currentDate = "Date"
    @Published var cvc = "000"
    var years = Array(1900...2024).map { String($0) }
    
    func format(cardNumber: String) -> String {
        let number = cardNumber.replacingOccurrences(of: "[^0-9]",
                                                with: "",
                                                options: .regularExpression)
        let mask = "XXXX XXXX XXXX XXXX"
        var result = ""
        var index = number.startIndex
        for char in mask where index < number.endIndex {
            if char == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
}
