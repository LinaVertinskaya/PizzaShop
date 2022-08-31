//
//  OrderStatus.swift
//  PizzaShop
//
//  Created by Лина Вертинская on 27.08.22.
//

import Foundation

enum OrderStatus: String, CaseIterable {
    case new = "Новый"
    case cooking = "Готовится"
    case delivery = "Доставляется"
    case completed = "Выполнен"
    case cancelled = "Отменен"
}
