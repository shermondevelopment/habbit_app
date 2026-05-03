//
//  CustomTextFieldStyle.swift
//  Habit
//
//  Created by VITOR SHERMON on 27/04/26.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    
    var hasError: Bool = false
    
    @FocusState private var isFocused: Bool
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(hasError ? Color.red : Color.orange, lineWidth: 0.8)
            )
            .contentShape(Rectangle())
            .onTapGesture {
                isFocused = true
            }
        
    }
}
