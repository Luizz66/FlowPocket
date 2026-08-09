//
//  MaskTextField.swift
//  FlowPocket
//
//  Created by Luiz Gustavo Barros Campos on 23/05/26.
//

import SwiftUI

public enum TextInputKind {
    case password(min: Int = 6)
    case name
    case email
    case digits
    case freeText
    case date
}

public struct InputMaskModifier: ViewModifier {
    let kind: TextInputKind
    @Binding var text: String
    
    public func body(content: Content) -> some View {
        content
            .onChange(of: text) { newValue, _ in
                let formatted: String
                switch kind {
                case .name:
                    formatted = InputMask.nameOnly(newValue)
                    
                case .digits:
                    formatted = InputMask.digitsOnly(newValue)
                    
                case .email:
                    formatted = InputMask.emailOnly(newValue)
                    
                case .password:
                    formatted = InputMask.passwordOnly(newValue)
                    
                case .date:
                    formatted = InputMask.dateOnly(newValue)
                    
                case .freeText:
                    formatted = newValue
                }
                
                text = formatted
            }
    }
}

public struct InputDecorationModifier: ViewModifier {
    public let state: InputState
    public let spacingBelow: CGFloat
    
    public init(state: InputState, spacingBelow: CGFloat = 6) {
        self.state = state
        self.spacingBelow = spacingBelow
    }
    
    public func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: spacingBelow) {
            content
            if let message = state.messageText, !message.isEmpty {
                Text(message)
                    .font(.footnote)
                    .foregroundColor(state.messageColor)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibilityLabel(message)
            }
        }
    }
}

// MARK: - Máscara do Input para formatação automática
public struct InputMask {
    public static func digitsOnly(_ raw: String) -> String {
        raw.filter(\.isNumber)
    }
    
    public static func nameOnly(_ raw: String) -> String {
        let allowed = CharacterSet.letters
            .union(.whitespaces)
        
        let filtered = raw.unicodeScalars
            .filter { allowed.contains($0) }
        
        return String(
            String.UnicodeScalarView(filtered)
        )
    }
    
    public static func emailOnly(_ raw: String) -> String {
        raw.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        .lowercased()
    }
    
    public static func passwordOnly(_ raw: String) -> String {
        raw.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
    }
    
    public static func dateOnly(_ raw: String) -> String {
        let digits = raw
            .filter(\.isNumber)
            .prefix(8)
        
        var result = ""
        
        for (index, char) in digits.enumerated() {
            
            if index == 2 || index == 4 {
                result.append("/")
            }
            result.append(char)
        }
        
        return result
    }
}

// MARK: - Validação do input para caracteres corretos
public enum InputValidator {
    public static func isValid(_ text: String, for kind: TextInputKind) -> Bool {
        switch kind {
            
        case .password(let min):
            return text.count >= min
            
        case .name:
            return text
                .trimmingCharacters( in: .whitespacesAndNewlines)
                .count >= 2
            
        case .email:
            let regex = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
            
            return text
                .uppercased()
                .range(of: regex, options: .regularExpression) != nil
            
        case .digits:
            return text.contains {
                $0.isNumber
            }
            
        case .freeText:
            return !text
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
            
        case .date:
            let regex = #"^(?:(?:31/(?:0[13578]|1[02]))|(?:30/(?:0[13-9]|1[0-2]))|(?:29/(?:0[1-9]|1[0-2]))|(?:0[1-9]|1\d|2[0-8])/(?:0[1-9]|1[0-2]))/\d{4}$"#
            
            return text.range(of: regex, options: .regularExpression) != nil
        }
    }
}

// MARK: - States
public enum InputState: Equatable {
    case neutral
    case error(message: String)
    case success(message: String? = nil)
    
    public var borderColor: Color {
        switch self {
        case .neutral: return Color(white: 0.9)
        case .error:   return Color.red.opacity(0.7)
        case .success: return Color.green.opacity(0.6)
        }
    }
    public var messageText: String? {
        switch self {
        case .error(let msg): return msg
        case .success(let msg): return msg
        case .neutral: return nil
        }
    }
    public var messageColor: Color {
        switch self {
        case .error: return .red
        case .success: return .green
        case .neutral: return .clear
        }
    }
}
