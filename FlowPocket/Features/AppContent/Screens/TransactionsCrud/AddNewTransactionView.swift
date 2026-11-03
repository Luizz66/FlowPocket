//
//  AddNewTransactionView.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 30/03/26.
//

import SwiftUI
import CoreData

struct AddNewTransactionView: View {
    @EnvironmentObject private var transactionsStore: TransactionsStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var type: Category.T = .income
    @State private var title: String = ""
    @State private var value: String = ""
    @State private var category: Category = .none
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack(spacing: 15) {
            SegmentedPicker(
                options: Category.T.self,
                selection: $type
            )
            .padding(.bottom)
            
            CustomTextField(
                text: $title,
                placeholder: "Título",
                kind: .freeText
            )
            
            CustomTextField(
                text: $value,
                placeholder: "Valor",
                kind: .digits
            )
            
            CategoryPicker(
                selection: $category,
                type: type
            )
            
            CustomDatePicker(selectedDate: $selectedDate)
            
            Spacer()
            
            CustomBtn(txt: "Salvar", colorBtn: .mainBlue) {
                addItem()
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.bg)
        .toolbar {
            backButton()
        }
        .onChange(of: type) {
            category = .none
        }
    }
    
    // MARK: - View Builders

    
    // MARK: - Funcs
    private func addItem() {
        guard let decimalValue = Decimal(string: value, locale: Locale.current) else {
            return
        }
        
        withAnimation {
            transactionsStore.create(
                type: type.rawValue,
                title: title,
                value: decimalValue,
                category: category.name,
                date: selectedDate
            )
        }
    }
    
    private func backButton() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
            }
        }
    }
}

// MARK: - Preview
private struct AddNewTransactionView_PreviewContainer: View {
    var body: some View {
        AddNewTransactionView()
            .environmentObject(
                TransactionsStore(
                    context: CoreDataManager.shared.container.viewContext
                )
            )
    }
}

#Preview("Light Mode") {
    AddNewTransactionView_PreviewContainer()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    AddNewTransactionView_PreviewContainer()
        .preferredColorScheme(.dark)
}
