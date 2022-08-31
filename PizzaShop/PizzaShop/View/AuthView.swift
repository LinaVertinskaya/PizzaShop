//
//  ContentView.swift
//  PizzaShop
//
//  Created by Лина Вертинская on 21.08.22.
//

import SwiftUI

struct AuthView: View {

    @State private var isAuth = true

    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isTabViewShow = false
    @State private var isShowAlert = false
    @State private var alertMessage = ""

    var body: some View {

        VStack(spacing: 20) {
            Text(isAuth ? "Авторизация" : "Регистрация")
                .padding(isAuth ? 16 : 24)
                .padding()
                .padding(.horizontal, 30)
                .font(.title2.bold())
                .background(Color("whitealpha"))
                .cornerRadius(isAuth ? 30 : 60)
                .foregroundColor(Color("darkbrown"))

            VStack {
                TextField("Введите e-mail", text: $email)
                    .padding()
                    .background(Color("whitealpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)

                SecureField("Введите пароль", text: $password)
                    .padding()
                    .background(Color("whitealpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)

                if !isAuth {
                    SecureField("Повторите пароль", text: $confirmPassword)
                        .padding()
                        .background(Color("whitealpha"))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                }

                Button {
                    if isAuth {
                        print("Авторизация пользователя через Firebase")

                        AuthService.shared.signIn(email: self.email, password: self.password) { result in
                            switch result {
                            case .success(_):
                                isTabViewShow.toggle()
                            case .failure(let error):
                                alertMessage = "Ошибка авторизации: \(error.localizedDescription)"
                                isShowAlert.toggle()
                            }
                        }
                    } else {
                        print("Регистрация пользователя")

                        guard password == confirmPassword else {
                            self.alertMessage = "Пароли не совпадают"
                            self.isShowAlert.toggle()
                            return
                        }

                        AuthService.shared.signUp(email: self.email, password: self.password) { result in
                            switch result {
                            case .success(let user):
                                alertMessage = "Вы зарегистрировались с e-mail \(user.email!)"
                                self.isShowAlert.toggle()
                                self.email = ""
                                self.password = ""
                                self.confirmPassword = ""
                                self.isAuth.toggle()
                            case .failure(let error):
                                alertMessage = "Ошибка регистрации \(error.localizedDescription)!"
                                self.isShowAlert.toggle()
                            }
                        }
                    }
                } label: {
                    Text(isAuth ? "Войти" : "Создать аккаунт")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [Color("yellow"), Color("orange")], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(Color("darkbrown"))
                }

                Button {
                    isAuth.toggle()
                } label: {
                    Text(isAuth ? "Еще не с нами?" : "Уже есть аккаунт")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(Color("darkbrown"))
                }
            }
            .padding()
            .padding(.top, 16)
            .background(Color("whitealpha"))
            .cornerRadius(24)
            .padding(isAuth ? 30 : 12)
            .alert(alertMessage, isPresented: $isShowAlert) {
                Button { } label: {
                    Text("OK")
                }
            }

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("bg")
                .ignoresSafeArea()
                .blur(radius: isAuth ? 0 : 6))
            .animation(Animation.easeInOut(duration: 0.3), value: isAuth)
            .fullScreenCover(isPresented: $isTabViewShow) {

                if AuthService.shared.currentUser?.uid == "mtCvZLkUEIaM7P3QszAuPq3u2UF2" {
                    AdminOrdersView()
                } else {
                    let mainTabBarViewModel = MainTabBarViewModel(user: AuthService.shared.currentUser!)

                    MainTabBar(viewModel: mainTabBarViewModel)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
