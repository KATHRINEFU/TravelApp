//
//  DataModels.swift
//  Travel App Clive
//
//  Created by null-reaper on 9/30/23.
//
//  [TODO] Split into separate files later
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    var user_name: String
    var user_profile: String
    var timestamp: String
    var text: String
    var image: String
}
