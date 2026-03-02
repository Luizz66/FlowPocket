//
//  Icons.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 01/03/26.
//

import SwiftUI

class Icons {
    func sfSymbol(type: Category.income) -> String {
        switch type {
        case .salario:
            return "brazilianrealsign.arrow.trianglehead.counterclockwise.rotate.90"
        case .freelance:
            return "person.fill.checkmark"
        case .extra:
            return "banknote"
        case .transferencia:
            return "arrow.up.arrow.down"
        case .investimentos:
            return "chart.line.uptrend.xyaxis"
        case .servicos:
            return "wrench.adjustable"
        case .outros:
            return "circle.grid.2x2"
        }
    }
    
    func sfSymbol(type: Category.expense) -> String {
        switch type {
        case .casa:
            return "house"
        case .educacao:
            return "book.closed"
        case .eletronicos:
            return "gamecontroller"
        case .lazer:
            return "chair.lounge"
        case .assinaturas:
            return "calendar.badge.clock"
        case .restaurante:
            return "fork.knife"
        case .saude:
            return "cross"
        case .servicos:
            return "wrench.adjustable"
        case .supermercado:
            return "cart"
        case .transporte:
            return "car"
        case .vestuario:
            return "bag"
        case .viagem:
            return "airplane"
        case .outros:
            return "circle.grid.2x2"
        }
    }
}
