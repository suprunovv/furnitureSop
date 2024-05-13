import SwiftUI

struct CardView: View {
    var cardNumber: String
    var cardName: String
    var cvc: String
    @State private var isFliped = false
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(LinearGradient(
                        colors: [.startBackgraund, .endBackgraund],
                        startPoint: .leading,
                        endPoint: .trailing))
                    .shadow(radius: 2, y: 5)
                VStack(alignment: .leading) {
                    if isFliped {
                        flipedBody
                    } else {
                        logoBody
                        informationBody
                        Spacer()
                    }
                }.padding([.leading], 30)
            }.frame(width: 310, height: 180)
            .rotation3DEffect(.degrees(isFliped ? 360 : 0), axis: (x: 0, y: 1, z: 0))
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.6)){
                    isFliped.toggle()
                }
            }
    }
    
   private var logoBody: some View {
        HStack {
            Spacer()
            Image("logoMir")
        }.padding([.top, .trailing])
    }
    
    private var flipedBody: some View {
        VStack(alignment: .leading, spacing: 13) {
            Text(cardNumber)
                .frame(width: 250, alignment: .leading)
                .foregroundColor(.white)
                .font(.verdanaBold(size: 20))
            HStack {
                Text(cvc)
                    .font(.verdanaBold(size: 20))
                    .foregroundColor(.white)
                Text("CVC/CVV")
                    .foregroundColor(.textColor)
            }
            HStack {
                Text("01/28")
                    .font(.verdanaBold(size: 20))
                    .foregroundColor(.white)
                Text("Valid")
                    .foregroundColor(.textColor)
            }
        }.padding(0)
    }
    
    private var informationBody: some View {
        VStack(alignment: .leading ,spacing: 0) {
            Text(maskText(cardNumber))
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
            Text("Card number")
                .foregroundColor(.white)
                .opacity(0.5)
            Spacer().frame(height: 17)
            Text(cardName)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
            Text("Cardholder")
                .foregroundColor(.white)
                .opacity(0.5)
        }
    }
    
    func maskText(_ text: String) -> String {
        guard text.count > 4 else { return text }
            let masked = String(repeating: "*", count: text.count - 4) + text.suffix(4)
            return stride(from: 0, to: masked.count, by: 5).map {
                let start = masked.index(masked.startIndex, offsetBy: $0)
                let end = masked.index(start, offsetBy: 4, limitedBy: masked.endIndex) ?? masked.endIndex
                return String(masked[start..<end])
            }.joined(separator: " ")
    }
}
