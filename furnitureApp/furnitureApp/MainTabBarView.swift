
import SwiftUI

struct MainTabBarView: View {
    
    @State var currentTabView = 0
    
    var body: some View {
        TabView(selection: $currentTabView) {
            HomeView()
                .tabItem({
                    Image("home")
                })
                .tag(0)
            SearchView()
                .tabItem({
                    Image("basket")
                })
                .tag(1)
            ProfileView()
                .tabItem({
                    Image("smile")
                })
                .tag(2)
        }.navigationBarBackButtonHidden(true)
    }
}


struct NavigationModify: ViewModifier {
        var height: CGFloat

        func body(content: Content) -> some View {
            content
                .foregroundStyle(LinearGradient(colors: [.startBackgraund, .endBackgraund], startPoint: .leading, endPoint: .trailing))
                .frame(height: height)
        }
}

struct SearchView: View {
    
    var body: some View {
        VStack {
            
        }
    }
}

struct CustomSlider: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    var step: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Slider(value: $value, in: range, step: step)
                    .overlay(
                        Text("$\(Int(value))")
                            .bold()
                            .frame(width: 100, alignment: .leading)
                            .background(Color.clear)
                            .offset(x: CGFloat(value / range.upperBound) * geometry.size.width - 180, y: 25)
                    )
                    .onAppear {
                        UISlider.appearance().setThumbImage(UIImage(named: "thumb"), for: .normal)
                    }
                
            }
        }
        .frame(height: 30)
    }
}
