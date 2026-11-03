//
//  CategoryPicker.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 02/11/26.
//

import SwiftUI

private let defaultName = "Categoria"

struct CategoryPicker: View {
    @Binding var selection: Category

    let type: Category.T

    private let inputTextColorPrimary = Color(.textPrimary)
    private let inputFillColor = Color(.backdrop)
    private let inputBorderColor = Color(.textPrimary)

    private var selectedName: String {
        selection.name.isEmpty ? defaultName : selection.name
    }
    
    var body: some View {
        Menu {
            switch type {
            case .income:
                ForEach(Income.allCases) { item in
                    Button(item.rawValue) {
                        selection = .income(item)
                    }
                }

            case .expense:
                ForEach(Expense.allCases) { item in
                    Button(item.rawValue) {
                        selection = .expense(item)
                    }
                }
            }
        } label: {
            HStack {
                Text(selectedName)
                    .font(.myFont(size: 18, weight: .regular))
                    .foregroundColor(inputTextColorPrimary)
                
                Spacer()

                Image(systemName: "chevron.up.chevron.down")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color(.textSecondary))
            }
            .frame(height: 39)
            .contentShape(Rectangle())
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        .background(inputFillColor)
        .overlay(
            RoundedRectangle(cornerRadius: 9)
                .stroke(inputBorderColor, lineWidth: 2)
        )
        .cornerRadius(9)
        .transaction { $0.disablesAnimations = false }
    }
}

extension Category {
    var name: String {
        switch self {
        case .none:
            return defaultName

        case .income(let item):
            return item.rawValue

        case .expense(let item):
            return item.rawValue
        }
    }
}

// MARK: - Preview
struct CategoryPicker_PreviewContainer: View {

    @State private var type: Category.T = .income
    @State private var category: Category = .income(.salario)

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            Picker("Tipo", selection: $type) {
                ForEach(Category.T.allCases) { item in
                    Text(item.rawValue.isEmpty ? "Selecione" : item.rawValue)
                        .tag(item)
                }
            }
            .font(.myFont(size: 18, weight: .regular))
            .tint(Color(.textPrimary))

            CategoryPicker(
                selection: $category,
                type: type
            )

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.bg)
        .onChange(of: type) {
            switch type {
            case .income:
                category = .income(.salario)

            case .expense:
                category = .expense(.casa)
            }
        }
    }
}

#Preview("Category Picker Light") {
    CategoryPicker_PreviewContainer()
        .preferredColorScheme(.light)
}

#Preview("Category Picker Dark") {
    CategoryPicker_PreviewContainer()
        .preferredColorScheme(.dark)
}
