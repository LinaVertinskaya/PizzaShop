//
//  MainTabBarViewModel.swift
//  PizzaShop
//
//  Created by Лина Вертинская on 25.08.22.
//

import Foundation
import Firebase
import FirebaseAuth

class MainTabBarViewModel: ObservableObject {

    @Published var user: User

    init(user: User) {
        self.user = user
    }
}
