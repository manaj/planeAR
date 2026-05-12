//
//  Item.swift
//  planeAR
//
//  Created by Manaj on 2026-05-12.
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
