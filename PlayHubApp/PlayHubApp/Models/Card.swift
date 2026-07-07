//
//  Card.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import Foundation

// Represents a single card in the Light It Up grid
struct Card: Identifiable {
    let id: Int
    var isLit: Bool = false
}
