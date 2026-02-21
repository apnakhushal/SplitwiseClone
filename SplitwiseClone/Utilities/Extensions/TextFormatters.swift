//
//  TextFormatters.swift
//  SplitwiseClone
//
//  Created by apple on 17.01.26.
//

import SwiftUI

struct TextFormatters {
    static func formatExpenseText(
        fullText: String,
        highlighted: String,
        color: Color
    ) -> AttributedString {
        var attributed = AttributedString(fullText)
        
        if let range = attributed.range(of: highlighted) {
            attributed[range].foregroundColor = color
        }
        return attributed
    }
}
