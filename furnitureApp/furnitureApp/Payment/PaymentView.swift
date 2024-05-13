import SwiftUI

struct PaymentView: View {
    
    @State private var pressAddNow = false
    @State private var showYearsPicker = false
    @State private var showDatePicker = false
    @State private var secureCvc = true
    @FocusState private var focusCvc: Bool?
    @StateObject private var viewModel = PaymentViewModel()
    @Environment(\.presentationMode) private var presenttionMode
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .modifier(NavigationModify(height: 118))
                navigationBody
            }
            Spacer().frame(height: 32)
            CardView(cardNumber: viewModel.cardNumber, cardName: viewModel.cardName, cvc: viewModel.cvc)
            Spacer().frame(height: 33)
            textFieldsBody
            buttonBody
            Spacer()
        }.ignoresSafeArea(.all, edges: .top)
            .navigationBarBackButtonHidden(true)
    }
    
    private var textFieldsBody: some View {
        VStack(alignment: .leading, spacing: 0) {
            createTextFiled(title: "Add new card", placeholder: "Cardholder name", binding: $viewModel.cardNumber, isMask: true)
            Spacer().frame(height: 11)
            createTextFiled(title: "Card number", placeholder: "0000 0000 0000 0000", binding: $viewModel.cardName, isMask: false)
            HStack(spacing: 80) {
                createPicker(title: $viewModel.currentDate, value: [], binding: $showDatePicker)
                createPicker(title: $viewModel.currentYear, value: viewModel.years, binding: $showYearsPicker)
            }.padding()
            createCvcTextField(text: $viewModel.cvc, binding: $secureCvc)
        }
    }

    private var navigationBody: some View {
        HStack(alignment: .center) {
            Button {
                presenttionMode.wrappedValue.dismiss()
            } label: {
                Image("backButton")
                    .foregroundColor(.white)
            }.padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text("Payment")
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            Spacer().frame(maxWidth: .infinity)
                .padding()
        }.padding([.top], 20)
    }
    
    private var buttonBody: some View {
        Button {
            pressAddNow.toggle()
        } label: {
            Text("Add now")
                .foregroundColor(.white)
                .font(.verdanaBold(size: 20))
        }.frame(width: 300, height: 55)
        .background(LinearGradient(colors: [.startBackgraund, .endBackgraund], startPoint: .leading, endPoint: .trailing))
        .clipShape(RoundedRectangle(cornerRadius: 27))
        .alert(isPresented: $pressAddNow) {
            var alert: Alert
            if viewModel.cvc.count < 3 {
               alert = Alert(title: Text("Ошибка!"), message: Text("cvc должен быть равен 3 цифрам"))
            } else {
               alert = Alert(title: Text("Всё хорошо"), message: Text("Ты молодец!"))
            }
            return alert
        }

    }
    
    private func createTextFiled(title: String, placeholder: String, binding: Binding<String>, isMask: Bool) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.verdanaBold(size: 20))
                .foregroundColor(.textColor)
            if isMask {
                TextField(placeholder, text: binding)
                    .keyboardType(.numberPad)
                    .font(.verdana(size: 20))
                    .foregroundColor(.textColor)
                    .onChange(of: binding.wrappedValue) { newValue in
                    binding.wrappedValue = viewModel.format(cardNumber: newValue)
                }
            } else {
                TextField(placeholder, text: binding)
                    .font(.verdana(size: 20))
                    .foregroundColor(.textColor)
            }
            Divider().frame(width: 350)
        }.padding([.leading, .trailing])
    }
    
    private func createCvcTextField(text: Binding<String>, binding: Binding<Bool>) -> some View {
        VStack(alignment: .leading) {
            Text("CVC")
                .font(.verdanaBold(size: 20))
                .foregroundColor(.textColor)
            HStack {
                if binding.wrappedValue {
                    SecureField("000", text: text)
                        .font(.verdana(size: 20))
                        .foregroundColor(.textColor)
                        .focused($focusCvc, equals: true)
                        .onChange(of: text.wrappedValue) { newValue in
                            if newValue.count <= 3 {
                                text.wrappedValue = newValue
                            } else {
                                text.wrappedValue = String(newValue.prefix(3))
                                focusCvc = nil
                            }
                        }
                } else {
                    TextField("000", text: text)
                        .font(.verdana(size: 20))
                        .foregroundColor(.textColor)
                        .focused($focusCvc, equals: true)
                        .onChange(of: text.wrappedValue) { newValue in
                            if newValue.count <= 3 {
                                text.wrappedValue = newValue
                            } else {
                                focusCvc = nil
                                text.wrappedValue = String(newValue.prefix(3))
                            }
                        }
                }
                Button {
                    binding.wrappedValue.toggle()
                } label: {
                    Image(binding.wrappedValue ? "eye.slash" : "eye")
                }

            }
            Divider().frame(width: 350)
        }.padding()
    }
    
  private func createPicker(title: Binding<String>, value: [String], binding: Binding<Bool>) -> some View {
        VStack {
            Button {
                binding.wrappedValue.toggle()
            } label: {
                HStack {
                    Text(title.wrappedValue)
                        .frame(width: 60)
                        .font(.verdana(size: 20))
                        .lineLimit(1)
                    Spacer().frame(width: 37)
                    Image(systemName: "chevron.down")
                }.foregroundColor(.textColor)
            }.popover(isPresented: binding) {
                List(value, id: \.self) { item in
                    Text(item).onTapGesture {
                        title.wrappedValue = item
                        binding.wrappedValue = false
                    }
                }
            }
            Divider().frame(width: 110)
        }
    }
}

