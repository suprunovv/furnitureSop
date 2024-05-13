
import SwiftUI

struct VerificationView: View {
    
    private enum Constants {
        static let checkSms = "Check the SMS"
        static let message = "message to get verification code"
        static let contin = "Continue"
        static let recivedSms = "Didn’t receive sms"
        static let sendSms = "Send sms again"
        static let alertTitle = "Fill in from message"
    }
    
    private enum CodeTextFields {
        case one
        case two
        case thre
        case four
    }
    @Environment(\.presentationMode) var presenttionMode
    
    @ObservedObject private var viewModel = VerificationViewModel()
    @State var isShowAlert = false
    @State var isTapContinue = false
    @FocusState private var currentText: CodeTextFields?
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .modifier(NavigationModify(height: 118))
                HStack(alignment: .center) {
                    Button {
                        presenttionMode.wrappedValue.dismiss()
                    } label: {
                        Image("backButton")
                            .foregroundColor(.white)
                    }.padding()
                    Spacer().frame(maxWidth: 84)
                    Text("Verification")
                        .padding()
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                }.padding([.top], 20)
            }.blur(radius: isShowAlert ? 5 : 0)
            ZStack {
                VStack {
                    Image("sms")
                    Text("Verification code")
                    codeBody
                    Spacer().frame(maxHeight: 20)
                    checkSmsBody
                    Spacer()
                }.blur(radius: isShowAlert ? 5 : 0)
                if isShowAlert {
                  alertView
                        .transition(.slide)
                        .zIndex(1)
                }
            }
        }.ignoresSafeArea()
    }
    
    private var codeBody: some View {
        HStack {
            createTextFiled(title: "1", $viewModel.oneTextField)
                .focused($currentText, equals: .one)
                .onChange(of: viewModel.oneTextField) { newValue in
                    if newValue.count == 1 { currentText = .two }
                }
            createTextFiled(title: "2", $viewModel.twoTextField)
                .focused($currentText, equals: .two)
                .onChange(of: viewModel.twoTextField) { newValue in
                    if newValue.count == 1 { currentText = .thre }
                }
            createTextFiled(title: "3", $viewModel.threTextField)
                .focused($currentText, equals: .thre)
                .onChange(of: viewModel.threTextField) { newValue in
                    if newValue.count == 1 { currentText = .four }
                }
            createTextFiled(title: "4", $viewModel.fourTextField)
                .focused($currentText, equals: .four)
                .onChange(of: viewModel.fourTextField) { newValue in
                    if newValue.count == 1 { currentText = nil }
                }
        }.navigationBarBackButtonHidden(true)
    }
    
    private var checkSmsBody: some View {
        VStack(spacing: 0) {
            Text(Constants.checkSms)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.textColor)
            Text(Constants.message)
                .font(.system(size: 16))
                .foregroundColor(.textColor)
            Spacer().frame(height: 20)
            bottomBody
        }
    }
    
    var alertView: some View {
        VStack(spacing: 20) {
            Text("НЕ ЛЕЗЬ! ОНА ТЕБЯ СОЖРЕТ!!!")
                .foregroundStyle(.white)
            Image("medved")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundStyle(.white)
                .clipShape(Circle())
            Text(viewModel.currentCode.joined(separator: ""))
                .foregroundColor(.white)
                .font(.verdanaBold(size: 24))
            HStack(spacing: 20) {
                Button("Я упёртый") {
                    viewModel.updateTexts()
                    isShowAlert.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        currentText = nil
                    }
                }.padding()
                .frame(width: 130)
                .foregroundStyle(.white)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Button("Понял") {
                    withAnimation {
                        isShowAlert.toggle()
                    }
                }.padding()
                .frame(width: 130)
                .foregroundStyle(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }.padding(35)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.brown))
            .padding(.top, 100)
            .shadow(radius: 15)
    }
    
    private var bottomBody: some View {
        VStack(spacing: 20) {
            Button {
                isTapContinue.toggle()
            } label: {
                if isTapContinue {
                    ProgressView()
                        .foregroundStyle(.white)
                } else {
                    Text(Constants.contin)
                }
            }.frame(maxWidth: 300, maxHeight: 55)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .background(LinearGradient(colors: [.startBackgraund,
                                                    .endBackgraund],
                                           startPoint: .leading,
                                           endPoint: .trailing))
                .clipShape(RoundedRectangle(cornerRadius: 27))
                .shadow(color: .gray, radius: 2, x: 0, y: 3)
            VStack(spacing: 0) {
                Text(Constants.recivedSms)
                    .foregroundColor(.textColor)
                Spacer().frame(height: 7)
                Button {
                    viewModel.createCode()
                    withAnimation {
                        isShowAlert.toggle()
                    }
                } label: {
                    Text(Constants.sendSms)
                        .foregroundColor(.textColor)
                }.font(.system(size: 20, weight: .bold))
                Divider().frame(maxWidth: 160)
            }
        }
    }
    
    private func createTextFiled(title: String, _ text: Binding<String>) -> some View {
        TextField(title, text: text)
            .frame(width: 60, height: 60)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .font(.system(size: 40, weight: .bold))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .border(.gray, width: 1)
    }
    
}

