import SwiftUI

final class SettingSearchViewModel: ObservableObject {

    let categories = ["bed", "sofa", "chair"]
    let colors: [(name: String, red: Double, green: Double, blue: Double)] = [
        ("red", 255, 0, 0),
        ("green", 0, 255, 0),
        ("blue", 0, 0, 255),
        ("yellow", 255, 255, 0),
        ("cyan", 0, 255, 255),
        ("magenta", 255, 0, 255),
        ("silver", 192, 192, 192),
        ("maroon", 128, 0, 0),
        ("olive", 128, 128, 0),
        ("dark Green", 0, 128, 0),
        ("purple", 128, 0, 128),
        ("teal", 0, 128, 128),
        ("navy", 0, 0, 128),
        ("orange", 255, 165, 0),
        ("gold", 255, 215, 0),
        ("dark Gray", 105, 105, 105),
        ("pink", 255, 192, 203),
        ("light Pink", 255, 240, 245),
        ("lawn Green", 124, 252, 0),
        ("lemon Chiffon", 255, 250, 205)
    ]
    
    let collums: [GridItem] = [.init(.fixed(40), spacing: 16),
                               .init(.fixed(40), spacing: 16),
                               .init(.fixed(40), spacing: 16),
                               .init(.fixed(40), spacing: 16),]
    @Published var currentIndex: Int?
    var currentCollor: String {
        if let currentIndex {
            return "-" + " " + colors[currentIndex].name
        } else {
            return ""
        }
    }
}
