//
//  BaseCustomTextField.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 23/05/26.
//

import SwiftUI

struct BaseCustomTextField: ViewModifier {
    var kind: TextInputKind
    
    func body(content: Content) -> some View {
        configured(content)
    }
    
    @ViewBuilder
    private func configured(_ field: Content) -> some View {
        switch kind {
        case .email:
            field
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
        case .password:
            field
                .keyboardType(.asciiCapable)
                .textContentType(.password)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
        case .name:
            field
                .keyboardType(.default)
                .disableAutocorrection(false)
                .textInputAutocapitalization(.words)
        case .digits:
            field
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
        case .date:
            field
                .keyboardType(.numberPad)
                .textContentType(.none)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
        case .freeText:
            field
                .keyboardType(.default)
        }
    }
}
