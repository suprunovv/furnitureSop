import SwiftUI

struct ProfileView: View {
    
    @State var test = ""
    @ObservedObject private var viewModel = ProfileViewModel()
    
    var body: some View {
            VStack(spacing: 44) {
                Rectangle()
                    .modifier(NavigationModify(height: 100))
                avatarBody
                linkedListBody
                Spacer()
            }.ignoresSafeArea()
    }
    
   private var avatarBody: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .frame(height: 150)
                    .foregroundColor(.startBackgraund)
                Image("avatar")
            }
            VStack(spacing: 1) {
                Text("Your Name")
                    .font(.verdanaBold(size: 24))
                    .foregroundColor(.textColor)
                HStack {
                    Image("flagPoint")
                    Text("Sity")
                        .foregroundColor(.textColor)
                        .font(.verdana(size: 20))
                }
            }
        }
    }
    
   private var linkedListBody: some View {
        VStack {
            List(viewModel.links) { link in
                NavigationLink {
                    link.destenationView
                }
                label: {
                    createLinkRow(linkModel: link)
                }
            }.listStyle(.plain)
        }
    }
    
   private func createLinkRow(linkModel: ProfileLink) -> some View {
        HStack {
            Image(linkModel.imageName)
            Text(linkModel.title)
            Spacer()
            if let notify = linkModel.notify {
                ZStack {
                    Circle()
                        .foregroundStyle(LinearGradient(colors: [.startBackgraund, .endBackgraund], startPoint: .top, endPoint: .bottom))
                        .frame(height: 30)
                    Text("\(notify)")
                        .foregroundColor(.white)
                }
            }
        }.padding([.leading, .trailing], 30)
    }
    
    
}
