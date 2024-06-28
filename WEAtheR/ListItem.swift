import Foundation
import SwiftData

@Model
class ListItem {
    var name: String
    var quantity: Int
    var isChecked: Bool

    init(name: String, quantity: Int, isChecked: Bool) {
        self.name = name
        self.quantity = quantity
        self.isChecked = isChecked
    }
}
