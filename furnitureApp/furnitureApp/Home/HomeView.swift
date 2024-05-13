import SwiftUI

struct HomeView: View {
    @State var searchText = ""
    @StateObject var viewModel = HomeViewModel()
    @State private var isShowDetail = false
    @State private var currentIndex = 0
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .modifier(NavigationModify(height: 150))
                VStack {
                    Spacer().frame(height: 25)
                    searchView
                }
            }
            Spacer().frame(height: 20)
            priceBody
            Spacer().frame(height: 28)
            ScrollView {
                VStack {
                    ForEach(viewModel.products.indices, id: \.self) { index in
                        createProductCell(index: index)
                            .onTapGesture {
                                currentIndex = index
                                isShowDetail = true
                            }
                            .fullScreenCover(isPresented: $isShowDetail) {
                                DetailView(product: viewModel.products[currentIndex])
                            }
                    }
                }
            }
            Spacer()
        }.ignoresSafeArea(.all, edges: .top)
    }
    
    private var priceBody: some View {
        HStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(Color.startBackgraund)
                HStack {
                    Text("Your total price")
                        .frame(alignment: .leading)
                        .font(.verdana(size: 22))
                    Text("\(viewModel.totalPrice)$")
                        .font(.verdanaBold(size: 22))
                }
            }.frame(width: 300, height: 48)
            .offset(x: 10)
        }
    }
    
    private func createProductCell(index: Int) -> some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 20)
                .shadow(radius: 2)
                .foregroundColor(.white)
            HStack {
                Image(viewModel.products[index].imageName)
                    .resizable()
                    .frame(width: 140, height: 140)
                VStack {
                    Text(viewModel.products[index].name)
                        .font(.verdanaBold(size: 22))
                        .foregroundColor(.textColor)
                    HStack {
                        Text("\(viewModel.products[index].priceOnSale)$")
                            .font(.verdanaBold(size: 24))
                            .foregroundColor(.textColor)
                        Text("\(viewModel.products[index].fullPrice)$")
                            .font(.verdana(size: 24))
                            .foregroundColor(.textColor)
                            .strikethrough()
                    }.frame(width: 200)
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .foregroundColor(.milkColor)
                        HStack {
                            Spacer()
                            Button {
                                viewModel.products[index].minusCount()
                                viewModel.totalPrice -= viewModel.products[index].priceOnSale
                            } label: {
                                Text("-")
                            }.foregroundColor(.textColor)
                                .frame(alignment: .center)
                            Spacer()
                            Text("\(viewModel.products[index].count)")
                                .frame(alignment: .center)
                            Spacer()
                            Button {
                                viewModel.products[index].addCount()
                                viewModel.totalPrice += viewModel.products[index].priceOnSale
                            } label: {
                                Text("+")
                                    .frame(alignment: .center)
                            }.foregroundColor(.textColor)
                            Spacer()
                        }.font(.verdanaBold(size: 18))
                    }.frame(width: 115, height: 40)
                }
            }
        }.frame(maxWidth: 360, maxHeight: 150)
            .padding([.leading, .trailing, .top])
            
    }
    
    var searchView: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundColor(.white)
                HStack {
                    Image("search").padding(.leading)
                    Spacer()
                    TextField("Search...", text: $searchText)
                        .font(.verdana(size: 20))
                        .foregroundColor(.textColor)
                }
            }.frame(width: 312, height: 48)
            NavigationLink(destination: SettingSearchView()) {
                Image("settings")
            }
        }
    }
}
