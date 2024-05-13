import SwiftUI

struct SettingSearchView: View {
    @Environment(\.presentationMode) var presenttionMode
    @ObservedObject var viewModel = SettingSearchViewModel()
    @State private var price = 500.0
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .modifier(NavigationModify(height: 118))
                navigationBarView
            }
            furnitureTypeBody
            Spacer().frame(height: 45)
            VStack(alignment: .leading, spacing: 0) {
                priceSliderBody
                Text("$500")
                    .offset(x: -14)
                    .bold()
            }.padding([.leading, .trailing])
            colorsBody
            Spacer()
        }.ignoresSafeArea(.all, edges: .top)
    }
    
    private var colorsBody: some View {
        Section {
            LazyHGrid(rows: viewModel.collums, spacing: 30) {
                ForEach(viewModel.colors.indices, id: \.self) { index in
                    createCollorButton(index: index)
                }
            }
        } header: {
            HStack {
                Text("Color \(viewModel.currentCollor)")
                    .foregroundColor(.textColor)
                    .font(.verdanaBold(size: 24))
                Spacer()
            }
        }.padding()

    }
    
    private var navigationBarView: some View {
        HStack(alignment: .center) {
            Button {
                presenttionMode.wrappedValue.dismiss()
            } label: {
                Image("backButton")
                    .foregroundColor(.white)
            }.padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text("Filters")
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            Spacer().frame(maxWidth: .infinity)
                .padding()
        }.padding([.top], 20)
    }
    
    private var furnitureTypeBody: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.categories.indices, id: \.self) { index in
                        createTypeView(image: viewModel.categories[index])
                    }
                }
            }
        } header: {
            HStack {
                Text("Category").frame(alignment: .leading)
                    .foregroundColor(.textColor)
                Spacer()
                Text("More").frame(alignment: .trailing)
                    .foregroundColor(.gray)
                Image("chevron-right")
            }.padding([.leading, .trailing])
            .font(.verdanaBold(size: 24))
        }
    }
    
    private var priceSliderBody: some View {
        Section {
            CustomSlider(value: $price, range: 500...5000, step: 500)
        } header: {
            HStack {
                Text("Prices")
                    .font(.verdanaBold(size: 24))
                    .foregroundColor(.textColor)
                Spacer()
            }
        }
    }
    
    private func createTypeView(image: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.milkColor)
            Image(image)
        }.frame(width: 120, height: 80)
            .padding([.leading, .bottom])
            .shadow(radius: 2, y: 2)
    }
    
    private func createCollorButton(index: Int) -> some View {
        Button {
            viewModel.currentIndex = index
        } label: {
            Circle()
                .frame(width: 40)
                .foregroundColor(Color(red: viewModel.colors[index].red / 255, green: viewModel.colors[index].green / 255, blue: viewModel.colors[index].blue / 255))
        }

    }
    
}
