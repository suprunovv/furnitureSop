import SwiftUI

struct CircleView: View {

    private var gradient = LinearGradient(
        gradient: Gradient(colors: [.red, .blue]),
        startPoint: .trailing,
        endPoint: .leading)
    @State private var showNextScreen = false
    @State private var progressCount: CGFloat = 0
    @State private var counter = 0
    
    var body: some View {
        if showNextScreen {
            LoginView()
        } else {
            ZStack {
                LinearGradient(colors: [.startBackgraund, .endBackgraund], startPoint: .top, endPoint: .bottom)
                VStack {
                    progressCircleBody
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1.0 / 30, repeats: true) { timer in
                            progressCount += 1 / 100
                            counter += 1
                            if progressCount >= 1.0 {
                                timer.invalidate()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        showNextScreen = true
                                    }
                                }
                            }
                        }
                    }
                    Spacer().frame(height: 50)
                    if progressCount >= 1 {
                        Text("--ЧИНАЗЕС--")
                            .foregroundColor(.white)
                            .font(.verdanaBold(size: 30))
                    }
                }
            }.ignoresSafeArea(.all)
                .navigationBarBackButtonHidden(true)
        }
    }
    
    private var progressCircleBody: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray3), lineWidth: 20)
                .frame(width: 300, height: 300)
            Circle()
                .trim(from: 0, to: progressCount)
                .stroke(gradient, lineWidth: 20)
                .rotationEffect(.degrees(270))
                .frame(width: 300, height: 300)
                .overlay {
                    VStack {
                        Text("\(counter)%")
                            .font(.system(size: 80, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                        Text("Погоди брат!")
                            .font(.verdanaBold(size: 15))
                            .foregroundColor(.white)
                    }
                }
            
        }
    }
}
