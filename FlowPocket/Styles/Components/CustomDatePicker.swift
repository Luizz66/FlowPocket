//
//  CustomDatePicker.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 03/11/26.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var selectedDate: Date
    
    private let inputTextColorPrimary = Color(.textPrimary)
    private let inputFillColor = Color(.backdrop)
    
    var body: some View {
        DatePicker(
            "Data",
            selection: $selectedDate,
            displayedComponents: .date
        )
        .font(.myFont(size: 18, weight: .regular))
        .padding(8)
        .background(inputFillColor)
        .overlay(
            RoundedRectangle(cornerRadius: 9)
                .stroke(inputTextColorPrimary, lineWidth: 2)
        )
        .cornerRadius(9)
    }
}

// MARK: - Preview
struct CustomDatePicker_PreviewContainer: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        CustomDatePicker(selectedDate: $selectedDate)
            .padding()
    }
}

#Preview("Date Picker Light") {
    CustomDatePicker_PreviewContainer()
        .preferredColorScheme(.light)
}

#Preview("Date Picker Dark") {
    CustomDatePicker_PreviewContainer()
        .preferredColorScheme(.dark)
}
