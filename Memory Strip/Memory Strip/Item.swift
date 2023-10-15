//
//  Item.swift
//  Memory Strip
//
//  Created by null-reaper on 10/13/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
