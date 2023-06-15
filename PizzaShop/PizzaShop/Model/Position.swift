//
//  Position.swift
//  PizzaShop
//
//  Created by Лина Вертинская on 24.08.22.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Position: Identifiable {

    var id: String
    var product: Product
    var count: Int

    var cost: Int {
        return product.price * self.count
    }

    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["count"] = count
        repres["title"] = product.title
        repres["price"] = product.price
        repres["cost"] = cost
        return repres
    }

    internal init(id: String, product: Product, count: Int) {
        self.id = id
        self.product = product
        self.count = count
    }

    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()

        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }
        let product: Product = Product(id: "",
                                       title: title,
                                       imageUrl: "",
                                       price: price,
                                       descript: "")
        guard let count = data["count"] as? Int else { return nil }

        self.id = id
        self.product = product
        self.count = count
    }
}
