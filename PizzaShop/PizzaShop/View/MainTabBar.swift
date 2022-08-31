//
//  MainTabBar.swift
//  PizzaShop
//
//  Created by Лина Вертинская on 22.08.22.
//

import SwiftUI

struct MainTabBar: View {

    var viewModel: MainTabBarViewModel

    var body: some View {

        TabView {

            NavigationView {
                CatalogView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "menucard")
                    Text("Каталог")
                }
            }

            CartView(viewModel: CartViewModel.shared)
                .tabItem {
                    VStack {
                        Image(systemName: "cart")
                        Text("Корзина")
                    }
                }

            ProfileView(viewModel: ProfileViewModel(profile: MwUser(id: "",
                                                                    name: "",
                                                                    phone: 0000000000,
                                                                    address: "")))
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Профиль")
                    }
                }
        }
    }
}
