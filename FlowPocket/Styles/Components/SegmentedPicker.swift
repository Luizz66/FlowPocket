//
//  SegmentedPicker.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 02/11/26.
//

import SwiftUI

struct SegmentedPicker<T: RawRepresentable & CaseIterable & Identifiable>: View where T.RawValue == String {
    
    let options: T.Type
    
    @Binding var selection: T
    
    private let inputTextColorPrimary = Color(.textPrimary)
    private let inputFillColor = Color(.backdrop)
    
    private var selectedColor: Color {
        if options == Category.T.self {
            selection.rawValue == Category.T.income.rawValue ? Color.green : Color.tomato
        } else {
            Color.gray
        }
    }
    
    private var allOptions: [T] {
        Array(options.allCases)
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(allOptions) { item in
                optionButton(item)
            }
        }
        .padding(4)
        .frame(maxWidth: .infinity)
        .background(inputFillColor)
        .cornerRadius(9)
        .overlay(
            RoundedRectangle(cornerRadius: 9)
                .stroke(Color(.textPrimary), lineWidth: 0.8)
        )
    }
    
    // MARK: - View Builders
    private func optionButton(_ item: T) -> some View {
        let isSelected = selection.id == item.id
        
        return Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                selection = item
            }
        } label: {
            Text(item.rawValue)
                .font(.myFont(size: 18, weight: .regular))
                .foregroundColor(
                    isSelected ? .white : inputTextColorPrimary
                )
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(
                            isSelected
                            ? selectedColor.mix(with: .black, by: 0.2)
                            : Color.clear
                        )
                }
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
struct SegmentedPicker_PreviewContainer: View {
    @State private var type: Category.T = .income
    @State private var option: Ex = .one
    
    var body: some View {
        VStack {
            SegmentedPicker(
                options: Category.T.self,
                selection: $type
            )
            SegmentedPicker(
                options: Ex.self,
                selection: $option
            )
        }
        .padding()
    }
}

#Preview("Segmented Picker Light") {
    SegmentedPicker_PreviewContainer()
        .preferredColorScheme(.light)
}

#Preview("Segmented Picker Dark") {
    SegmentedPicker_PreviewContainer()
        .preferredColorScheme(.dark)
}

//Exemple
enum Ex: String, CaseIterable, Identifiable {
    case one = "Option one"
    case two = "Option two"
    
    var id: Self { self }
}
