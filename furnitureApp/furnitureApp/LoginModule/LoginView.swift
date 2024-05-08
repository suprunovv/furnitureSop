//
//  LoginView.swift
//  furnitureApp
//
//  Created by MacBookPro on 07.05.2024.
//

// unownedRectangle

import SwiftUI

struct LoginView: View {
    
    private enum Constants {
        static let numberMask = "+X (XXX) XXX-XX-XX"
        static let signUpText = "Sing up"
        static let forgot = "Forgot your password?"
        static let supportPhone = "+7(911)-442-11-64"
        static let supportTitle = "Телефон поддержки"
        static let checkVerification = "Check Verification"
    }
    
    private enum TextFields {
        case number
        case password
    }
    
    @FocusState private var currentTextField: TextFields?
    @ObservedObject var viewModel = LoginViewModel()
    @State private var isShowAlert = false
    @State private var isShowDetail = false
    
    var body: some View {
        
            VStack {
                LinearGradient(colors: [.startBackgraund, .endBackgraund],
                               startPoint: .leading,
                               endPoint: .trailing)
                .frame(maxHeight: 100)
                .ignoresSafeArea()
                VStack(spacing: 76) {
                    TitleLoginView()
                        .frame(width: 300, height: 55)
                    textFieldsBody
                }
                Spacer().frame(maxHeight: 95)
                bottomBody
                Spacer()
            }
        
        .navigationBarBackButtonHidden(true)
            .onTapGesture {
                currentTextField = nil
            }
    }
    
    private var textFieldsBody: some View {
        VStack(alignment: .leading) {
            TextField("Введите номер", text: Binding(get: {
                viewModel.numberText
            }, set: { newValue in
                viewModel.numberText = newValue
            })).frame(maxWidth: 350)
                .font(.system(size: 20, weight: .bold))
                .focused($currentTextField, equals: .number)
                .keyboardType(.numberPad)
                .onChange(of: viewModel.numberText) { newValue in
                    viewModel.numberText = viewModel.format(mask: Constants.numberMask,
                        phone: newValue)
                    if newValue.count == 18 {
                        currentTextField = .password
                    }
                }
            Divider().frame(maxWidth: 350)
            Spacer().frame(height: 24)
            Text("Password")
                .font(.system(size: 16, weight: .bold))
            Spacer().frame(maxHeight: 24)
            passwordBody
            Divider().frame(maxWidth: 350)
        }.padding()
    }
    
    private var passwordBody: some View {
        HStack {
            if viewModel.isSecurePassword {
                SecureField("Введите пароль", text: Binding(get: {
                    viewModel.passwordText
                }, set: { newValue in
                    viewModel.passwordText = newValue
                })).frame(maxWidth: 300)
                    .focused($currentTextField, equals: .password)
                    .font(.system(size: 20, weight: .bold))
            } else {
                TextField("Введите пароль", text: Binding(get: {
                    viewModel.passwordText
                }, set: { newValue in
                    viewModel.passwordText = newValue
                })).frame(maxWidth: 300, maxHeight: 24)
                    .focused($currentTextField, equals: .password)
                    .font(.system(size: 20, weight: .bold))
            }
            Spacer()
            Button {
                viewModel.isSecurePassword.toggle()
            } label: {
                Image(viewModel.isSecurePassword ? "eye.slash" : "eye")
            }.foregroundColor(.black)
        }
    }
    
    private var bottomBody: some View {
        VStack(spacing: 24) {
            Button {
                isShowDetail = true
            } label: {
                Text(Constants.signUpText)
            }.frame(maxWidth: 300, maxHeight: 55)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .background(LinearGradient(colors: [.startBackgraund,
                                                    .endBackgraund],
                                           startPoint: .leading,
                                           endPoint: .trailing))
                .clipShape(RoundedRectangle(cornerRadius: 27))
                .shadow(color: .gray, radius: 2, x: 0, y: 3)
                .fullScreenCover(isPresented: $isShowDetail) {
                    DetailView()
                }
            Button {
                isShowAlert.toggle()
            } label: {
                Text(Constants.forgot)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.textColor)
            }.alert(isPresented: $isShowAlert) {
                Alert(title: Text(Constants.supportTitle),
                      message: Text(Constants.supportPhone))
            }
            NavigationLink(destination: VerificationView()) {
                Text(Constants.checkVerification)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.textColor)
            }

        }
    }
}
