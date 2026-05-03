//
//  EditTextView.swift
//  Habit
//
//  Created by VITOR SHERMON on 27/04/26.
//

import SwiftUI

struct EditTextView: View {
    
    @Binding var text: String
    var placeholder: String = ""
    var keyboardType: UIKeyboardType = .default
    
    var error: String? = nil
    var failure: Bool? = nil
    
    var isSecure: Bool = false
    
    @Environment(\.colorScheme) private var colorScheme
    
    
    var body: some View {
        let hasError = (failure == true && !text.isEmpty)
        
        VStack(alignment: .leading) {
            ZStack {
                
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .foregroundColor(Color("textColor"))
                        .keyboardType(keyboardType)
                        .textFieldStyle(CustomTextFieldStyle(hasError: hasError))
                } else {
                    TextField(placeholder, text: $text)
                        .foregroundColor(Color("textColor"))
                        .keyboardType(keyboardType)
                        .textFieldStyle(CustomTextFieldStyle(hasError: hasError))
                        .textInputAutocapitalization(.never)
                }
                    
                
                if let error = error, failure == true, !text.isEmpty {
                    Text(error).foregroundColor(Color.red).fontWeight(.regular)
                        .font(Font.system(size: 14))
                        .padding(.horizontal, 10)
                        .background(colorScheme == .dark ? Color.black : Color.white)
                        .offset(x: 110, y: 25)
                }
            }
        }
    }
}

#Preview {
        EditTextView(
            text: .constant("Text"),
            placeholder: "Email",
            error: "Campo com error",
            failure: true
        ).preferredColorScheme(.dark)
}

#Preview {
        EditTextView(
            text: .constant("Text"),
            placeholder: "Email"
        ).preferredColorScheme(.light)
}
