//
//  MediaFile.swift
//  Memory Strip
//
//  Created by null-reaper on 10/14/23.
//

import SwiftUI

struct MediaFile: Identifiable {
    
    var id: String = UUID().uuidString
    var image: Image
    var data: Data
}
