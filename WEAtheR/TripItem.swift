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
    var listItems: [ListItem]
    
    init(title: String, location: String, date: String, occasion: String, listItems: [ListItem]) {
        self.title = title
        self.location = location
        self.date = date
        self.occasion = occasion
        self.listItems = listItems
    }
}
