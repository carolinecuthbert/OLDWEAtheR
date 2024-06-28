//
//  TripItem.swift
//  Trip
//
//  Created by Scholar on 6/26/24.
//

import Foundation
import SwiftData

@Model
class TripItem {
    var title: String
    var location: String
    var date: String
    var occasion: String
    
    init(title: String, location: String, date: String, occasion: String) {
        self.title = title
        self.location = location
        self.date = date
        self.occasion = occasion
    }
}
