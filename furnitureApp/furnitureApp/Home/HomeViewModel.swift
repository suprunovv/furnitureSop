import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var totalPrice = 0
    
    @Published var products = [Product(name: "Sofa", imageName: "sofa", priceOnSale: 999, fullPrice: 2000, count: 0), Product(name: "Armchair", imageName: "armchair", priceOnSale: 99, fullPrice: 200, count: 0), Product(name: "Bed", imageName: "bedTwo", priceOnSale: 1000, fullPrice: 2000, count: 0), Product(name: "Table", imageName: "table", priceOnSale: 600, fullPrice: 1200, count: 0), Product(name: "Сhair", imageName: "chairTwo", priceOnSale: 99, fullPrice: 200, count: 0), Product(name: "Wardrobe", imageName: "wardrobe", priceOnSale: 899, fullPrice: 1100, count: 0)]
}
