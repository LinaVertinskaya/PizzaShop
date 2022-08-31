//
//  MwUser.swift
//  PizzaShop
//
//  Created by Лина Вертинская on 25.08.22.
//

import Foundation

struct MwUser: Identifiable {

    var id: String
    var name: String
    var phone: Int
    var address: String

    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phone
        repres["address"] = self.address
        return repres
    }
}
