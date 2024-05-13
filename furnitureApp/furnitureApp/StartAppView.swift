//
//  ContentView.swift
//  furnitureApp
//
//  Created by MacBookPro on 06.05.2024.
//

import SwiftUI

struct StartAppView: View {
    
    private enum Constants {
        static let titleText = "169.ru"
        static let startedText = "Get Started"
        static let noAccountText = "Don't have an account?"
        static let signInText = "Sing in here"
    }
    
    @State private var isShowText = false
    @State private var opacityTitle = 0.0
    @State private var opasityButton = 0.0
    @State private var opasityBottom = 0.0
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.startBackgraund, .endBackgraund],
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                VStack {
                    Spacer().frame(maxHeight: 60)
                    titleBody
                        .opacity(opacityTitle)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 1.5)) {
                                        self.opacityTitle = 1.0
                                }
                            }
                    Spacer().frame(maxHeight: 116)
                    startedButtonBody
                        .opacity(opasityButton)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 1.5).delay(1)) {
                                        self.opasityButton = 1.0
                                }
                            }
                    Spacer().frame(maxHeight: 75)
                    bottomBody
                        .opacity(opasityBottom)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 2).delay(1.5)) {
                                        self.opasityBottom = 1.0
                                }
                            }
                    Spacer()
                }
                if isShowText {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.startBackgraund)
                        Text("Разработано при поддержке Грибковских пацанов!")
                            .frame(width: 150)
                            .lineLimit(nil)
                            .font(.verdanaBold(size: 14))
                            .foregroundColor(.textColor)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }.frame(width: 200, height: 200)
                }
            }
        }
    }
    
    private var titleBody: some View {
        VStack(spacing: 40) {
            Text(Constants.titleText)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
            titleImageBody
                .opacity(opasityBottom)
                .onAppear {
                withAnimation(Animation.easeInOut(duration: 2).delay(1.5)) {
                            self.opasityBottom = 1.0
                    }
                }
        }
    }
    
    private var titleImageBody: some View {
        AsyncImage(url: URL(string: "https://99px.ru/sstorage/53/2023/01/mid_348279_833663.jpg")) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .tint(.black)
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 296, height: 212)
                    .scaledToFit()
            case .failure(_):
                Image("title")
            @unknown default:
                fatalError()
            }
        }
    }
    
    private var startedButtonBody: some View {
        VStack {
            NavigationLink(destination: MainTabBarView(),
             label: {
                Text("")
                    .frame(maxWidth: 129, maxHeight: 24)
                    .foregroundColor(.black)
                    .background(LinearGradient(colors: [.startBackgraund, .endBackgraund], startPoint: .top, endPoint: .bottom))
                    .mask(Text(Constants.startedText)
                        .font(.system(size: 20, weight: .bold)))
            }).frame(maxWidth: 300, maxHeight: 55)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 27))
                .onLongPressGesture(minimumDuration: 1.5) {
                    withAnimation {
                        isShowText = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation {
                                isShowText = false
                            }
                        }
                    }
                }
        }
    }
    
    private var bottomBody: some View {
        VStack {
            Text(Constants.noAccountText)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
            NavigationLink(destination: CircleView(),
            label: {
                Text(Constants.signInText)
                    .foregroundColor(.white)
                    .frame(maxWidth: 200, maxHeight: 34)
                    .font(.system(size: 28, weight: .bold))
            })
            Divider().frame(maxWidth: 180, maxHeight: 2)
                .background(Color.white)
        }
    }
}




struct TitleLoginView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            Image("rectangleOne")
            Image("rectangleTwo").padding([.leading], 1)
            HStack {
                Text("Log in").padding()
                Text("Sign Up").padding()
            }.padding([.leading], 55)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(LinearGradient(colors: [.startBackgraund, .endBackgraund], startPoint: .top, endPoint: .bottom))
        }
    }
}


    

