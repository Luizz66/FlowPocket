//
//  Category.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 01/03/26.
//

import Foundation

import Foundation

enum Category: Hashable {
    case none
    case income(Income)
    case expense(Expense)

    enum T: String, CaseIterable, Identifiable {
        case income = "Renda"
        case expense = "Despesa"

        var id: Self { self }
    }
}

enum Income: String, CaseIterable, Identifiable {
    case salario = "Salário"
    case freelance = "Freelance"
    case extra = "Renda Extra"
    case transferencia = "Transferência"
    case investimentos = "Investimentos"
    case servicos = "Serviços"
    case outros = "Outros"

    var id: Self { self }
}

enum Expense: String, CaseIterable, Identifiable {
    case casa = "Casa"
    case educacao = "Educação"
    case eletronicos = "Eletrônicos"
    case lazer = "Lazer"
    case assinaturas = "Assinaturas"
    case restaurante = "Restaurante"
    case saude = "Saúde"
    case servicos = "Serviços"
    case supermercado = "Supermercado"
    case transporte = "Transporte"
    case vestuario = "Vestuário"
    case viagem = "Viagem"
    case outros = "Outros"

    var id: Self { self }
}
