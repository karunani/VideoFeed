//
//  Colors.swift
//  VideoFeed
//
//  Created by DFAdmin on 28/07/24.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

public enum BrandColor {
    public static let white = Color(hex: 0xFFFFFF)
    public static let grey1 = Color(hex: 0x111111)
    public static let grey2 = Color(hex: 0x222222)
    public static let grey3 = Color(hex: 0x888888)
    public static let grey4 = Color(hex: 0x444444)
    public static let grey5 = Color(hex: 0x555555)
    public static let grey6 = Color(hex: 0x666666)
    public static let grey7 = Color(hex: 0x777777)
    public static let grey8 = Color(hex: 0x888888)

    public static let backgroundColor = white
    public static let favIconColor = white

}

