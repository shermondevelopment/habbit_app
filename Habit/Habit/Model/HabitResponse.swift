//
//  HabitResponse.swift
//  Habit
//
//  Created by VITOR SHERMON on 05/05/26.
//
import Foundation

struct HabitResponse: Codable {
    let id: Int
    let name: String
    let label: String
    let iconUrl: String?
    let value: Int?
    let lastDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url"
        case lastDate = "last_date"
        case name
        case id
        case label
        case value
    }
}
