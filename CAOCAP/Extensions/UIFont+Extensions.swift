//
//  UIFont+Extensions.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 14/06/2023.
//

import UIKit.UIFont

extension UIFont {

    public enum MonogammaType: String {
        case regular = "Regular"
    }
    
    public enum UbuntuType: String {
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        case italic = "Italic"
        case light = "Light"
        case lightItalic = "LightItalic"
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        case regular = "Regular"
    }

    static func ubuntu(_ type: UbuntuType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Ubuntu-\(type.rawValue)", size: size)!
    }
    
    static func monogamma(_ type: MonogammaType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "monogamma-\(type.rawValue)", size: size)!
    }

    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }

}
