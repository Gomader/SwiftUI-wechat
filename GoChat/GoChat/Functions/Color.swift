//
//  Color.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/26.
//

import SwiftUI

extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}

extension UIColor{
    convenience init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            red: components.R,
            green: components.G,
            blue: components.B,
            alpha: alpha
        )
    }

    convenience init(normal: Int, normalAlpha: Double = 1, dark: Int? = nil, darkAlpha: Double = 1) {
        if (dark == nil), normalAlpha == darkAlpha {
            self.init(hex:normal, alpha:normalAlpha)
        }
        else {
            if #available(iOS 13.0, *) {
                self.init { (traitCollection: UITraitCollection) -> UIColor in
                    if (traitCollection.userInterfaceStyle == .dark) {
                        return UIColor(hex: dark ?? normal, alpha: darkAlpha)
                    }
                    else {
                        return UIColor(hex: normal, alpha: normalAlpha)
                    }
                };
            } else {
                self.init(hex:normal, alpha: normalAlpha)
            }
        }
    }
}
