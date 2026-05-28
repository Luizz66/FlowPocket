//
//  Validations.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 28/05/26.
//

import Foundation

func validateEmail(_ email: String) -> Bool {
    return email.contains("@") && email.contains(".")
}

func validadePassword(_ password: String) -> Bool {
    return password.count >= 6
}
