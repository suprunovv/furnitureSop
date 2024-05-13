import SwiftUI

final class ProfileViewModel: ObservableObject {
    let links = [ProfileLink(imageName: "mail", title: "Sity", notify: 3), ProfileLink(imageName: "ball", title: "Notification", notify: 4), ProfileLink(imageName: "people", title: "Accounts Details"), ProfileLink(imageName: "basketTwo", title: "My purchases"), ProfileLink(imageName: "setting", title: "Settings", destenationView: AnyView(PaymentView()))]
}

struct ProfileLink: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    var notify: Int?
    var destenationView: AnyView?
}


struct TabBarPreviews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
