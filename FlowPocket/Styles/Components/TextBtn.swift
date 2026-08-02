//
//  TextBtn.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 02/08/26.
//

import SwiftUI

struct TextBtn: View {
    let txt: String
    let action: () -> Void
    
    var body: some View {
        Button(txt) {
            action()
        }
        .foregroundColor(.textPrimary)
        .font(.myFont(style: .body, weight: .medium))
        .underline()
    }
}

#Preview {
    TextBtn(txt: "Não Possui Conta? Inscreva-se") {
        
    }
}
