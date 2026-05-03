//
//  LoadingButtonView.swift
//  Habit
//
//  Created by VITOR SHERMON on 28/04/26.
//

import SwiftUI

struct LoadingButtonView: View {
    
    var action: () -> Void
    var text: String = "Button"
    var disabled: Bool = false
    var loading: Bool = false
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }, label: {
                Text(loading ? " " : text)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .font(Font.system(.title3).bold())
                    .background(disabled ? Color("lightOrange") : Color.orange)
                    .cornerRadius(4)
            }).disabled(disabled || loading)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(loading ? 1 : 0)
        }
    }
}

#Preview {
    LoadingButtonView(action: {
        print("Ola mundo")
    }, text: "Entrar", disabled: true, loading: true).preferredColorScheme(.light)
}

#Preview {
    LoadingButtonView(action: {
        print("Ola mundo")
    }, text: "Entrar", disabled: false, loading: true).preferredColorScheme(.dark)
}
