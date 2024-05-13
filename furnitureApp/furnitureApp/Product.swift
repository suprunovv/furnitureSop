import Foundation

struct Product: Identifiable {
    var id = UUID()
    let name: String
    let imageName: String
    let priceOnSale: Int
    let fullPrice: Int
    var count: Int
    
    
    mutating func addCount() {
        count += 1
    }
    
    mutating func minusCount() {
        if count >= 1 {
            count -= 1
        }
    }
}
