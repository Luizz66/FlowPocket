//
//  CustomTxtField.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 30/03/26.
//

import SwiftUI

@ViewBuilder
func customTxtField(_ txt: Binding<String>, fill: Bool?, prompt: String) -> some View {
    TextField("", text: txt,
              prompt: fill == true ? Text(prompt)
        .font(.footnote)
        .italic()
        .foregroundColor(.red)
              : nil)
}
