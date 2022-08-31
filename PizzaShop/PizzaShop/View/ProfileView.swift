//
//  ProfileView.swift
//  PizzaShop
//
//  Created by Лина Вертинская on 22.08.22.
//

import SwiftUI

struct ProfileView: View {

    @State var isAvaAlertPresented = false
    @State var isQuitAlertPresented = false
    @State var isAuthViewPresented = false

    @StateObject var viewModel: ProfileViewModel

    var body: some View {

        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 16) {
                Image("user")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(8)
                    .background(Color("lightgray"))
                    .clipShape(Circle())
                    .onTapGesture {
                        isAvaAlertPresented.toggle()
                    }
                    .confirmationDialog("Откуда взять фото?", isPresented: $isAvaAlertPresented) {
                        Button {
                            print("Library")
                        } label: {
                            Text("Из галереи")
                        }
                        Button {
                            print("Camera")
                        } label: {
                            Text("С камеры")
                        }
                    }

                VStack(alignment: .leading, spacing: 12) {
                    TextField("Имя", text: $viewModel.profile.name)
                        .font(.body.bold())

                    HStack {
                        Text("+7")
                        TextField("Телефон", value: $viewModel.profile.phone, format: IntegerFormatStyle.number)
                    }
                }
            }.padding()

            VStack(alignment: .leading, spacing: 8) {
                Text("Адрес доставки:")
                    .bold()
                TextField("Ваш адрес", text: $viewModel.profile.address)
            }.padding(.horizontal)

            // Таблица с заказами
            List {
                if viewModel.orders.count == 0 {
                    Text("Ваши заказы будут тут")
                } else {
                    ForEach(viewModel.orders, id: \.id) { order in
                        OrderCell(order: order)
                    }
                }

            }.listStyle(.plain)

            Button {
                isQuitAlertPresented.toggle()
            } label: {
                Text("Выйти")
                    .padding()
                    .padding(.horizontal, 30)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }.padding()
                .confirmationDialog("Вы уверены, что хотите выйти?", isPresented: $isQuitAlertPresented) {
                    Button {
                        isAuthViewPresented.toggle()
                    } label: {
                        Text("Да")
                    }
                }
                .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                    AuthView()
                }
        }
        .onSubmit {
            viewModel.setProfile()
        }
        .onAppear {
            self.viewModel.getProfile()
            self.viewModel.getOrders()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(profile: MwUser(id: "", name: "Вася Иванов", phone: 9875667788, address: "Городок")))
    }
}
