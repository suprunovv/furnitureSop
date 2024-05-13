import SwiftUI

struct DetailView: View {
    @State private var editorText = ""
    var product: Product
    @State private var scale: CGFloat = 2
    @Environment(\.presentationMode) var presentationMode
    
    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
        VStack {
            topBody
            editorBody
        }.navigationBarBackButtonHidden(true)
    }
    
    private var magnificationView: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                scale = value
            }
            .onEnded { _ in
                scale = 2
            }
    }
    
    private var topBody: some View {
        VStack {
            HStack {
                Text(product.name)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.textColor)
                Spacer()
                Button {
                } label: {
                    Image(systemName: "heart")
                        .foregroundColor(.textColor)
                }
            }.padding()
            Image(product.imageName)
                .frame(width: 300, height: 177)
                .scaleEffect(scale)
                .gesture(magnificationView)
            HStack {
                Spacer()
                Text("Price: \(product.priceOnSale)$")
                    .frame(width: 200, height: 44)
                    .font(.system(size: 20, weight: .bold))
                    .background(Color.startBackgraund)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .offset(x: 15)
            }
        }
    }
    
    private var editorBody: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(LinearGradient(colors: [.startBackgraund, .endBackgraund], startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea()
            VStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("Article: ")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    + Text("283564")
                        .foregroundColor(.white)
                    Text("Description: ")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    + Text("A sofa in a modern style is furniture without lush ornate decor. It has a simple or even futuristic appearance and sleek design. ")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 350)
                Text("Review")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                HStack(alignment: .top) {
                    TextEditor(text: $editorText)
                        .frame(maxWidth: 285, maxHeight: 177)
                        .scrollContentBackground(.hidden)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .onReceive(editorText.publisher.collect()) {
                            editorText = String($0.prefix(300))
                        }
                    Text("\(editorText.count)/300")
                        .frame(width: 70)
                        .foregroundColor(.white)
                }.padding(.leading)
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Buy now")
                        .foregroundStyle(LinearGradient(colors: [.startBackgraund, .endBackgraund], startPoint: .bottom, endPoint: .top))
                        .font(.system(size: 20, weight: .bold))
                }.frame(maxWidth: 300, maxHeight: 55)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 27))
                    .shadow(radius: 10)

            }
        }
    }
}
