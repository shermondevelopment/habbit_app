//
//  Date+Extension.swift
//  Habit
//
//  Created by VITOR SHERMON on 05/05/26.
//

import Foundation

extension Date {
    func toBRString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: self)
    }
}
