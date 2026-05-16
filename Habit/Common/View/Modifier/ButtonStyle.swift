//
//  ButtonStyle.swift
//  Habit
//
//  Created by VITOR SHERMON on 04/05/26.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.white)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .font(Font.system(.title3).bold())
            .background(Color.orange)
            .cornerRadius(4)
    }
}
