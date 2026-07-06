import Foundation

// Represents a single card in the Light It Up grid
struct Card: Identifiable {
    let id: Int
    var isLit: Bool = false
}