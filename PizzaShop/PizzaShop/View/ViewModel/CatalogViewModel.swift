//
//  CatalogViewModel.swift
//  PizzaShop
//
//  Created by Лина Вертинская on 22.08.22.
//

import Foundation

class CatalogViewModel: ObservableObject {

    static let shared = CatalogViewModel()

    var popularProducts = [
        Product(id: "1",
                title: "Маргарита",
                imageUrl: "Not found",
                price: 450,
                descript: "Самая дешевая пицца"),
        Product(id: "2",
                title: "Баварская",
                imageUrl: "Not found",
                price: 350,
                descript: "Самая дешевая пицца"),
        Product(id: "3",
                title: "Пепперони",
                imageUrl: "Not found",
                price: 550,
                descript: "Самая дешевая пицца"),
        Product(id: "4",
                title: "Гавайская",
                imageUrl: "Not found",
                price: 400,
                descript: "Самая дешевая пицца"),
        Product(id: "5",
                title: "Сырная",
                imageUrl: "Not found",
                price: 620,
                descript: "Самая дешевая пицца")
    ]

    @Published var pizzas = [
        Product(id: "1",
                title: "Маргарита",
                imageUrl: "Not found",
                price: 450,
                descript: "Самая дешевая пицца"),
        Product(id: "2",
                title: "Баварская",
                imageUrl: "Not found",
                price: 350,
                descript: "Самая дешевая пицца"),
        Product(id: "3",
                title: "Пепперони",
                imageUrl: "Not found",
                price: 550,
                descript: "Самая дешевая пицца"),
        Product(id: "4",
                title: "Гавайская",
                imageUrl: "Not found",
                price: 400,
                descript: "Самая дешевая пицца"),
        Product(id: "5",
                title: "Сырная",
                imageUrl: "Not found",
                price: 620,
                descript: "Самая дешевая пицца")
    ]

    func getProducts() {
        DatabaseService.shared.getProducts { result in
            switch result {
            case .success(let products):
                self.pizzas = products
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
