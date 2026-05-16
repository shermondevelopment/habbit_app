//
//  GenderSelectView.swift
//  Habit
//
//  Created by VITOR SHERMON on 10/05/26.
//

import Foundation
import SwiftUI

struct GenderSelectView: View {
    
    @Binding var selectedGender: Gender
    var title: String = ""
    var genders: [Gender] = []
    
    var body: some View {
        Form {
            Section(header: Text(title)) {
                List(genders, id: \.self) { gender in
                    HStack {
                        Text(gender.rawValue)
                        Spacer()
                        if selectedGender == gender {
                            Image(systemName: "checkmark")
                                .foregroundColor(.orange)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !(selectedGender == gender) {
                            selectedGender = gender
                        }
                    }
                }
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
        }
    }
}

#Preview {
    GenderSelectView(selectedGender: .constant(.female), genders: Gender.allCases)
}
