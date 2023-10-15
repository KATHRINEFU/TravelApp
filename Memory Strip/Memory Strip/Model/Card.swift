//
//  Card.swift
//  Memory Strip
//
//  Created by null-reaper on 10/13/23.
//

import SwiftUI

struct Card: Identifiable, Hashable, Equatable {
    var id: UUID = .init()
    var image: String
    var previousOffset: CGFloat = 0
}
