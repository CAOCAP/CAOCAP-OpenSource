//
//  Enumerations.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 11/06/2023.
//

import Foundation


enum Direction: Int {
    //note: changing the order of the direction cases will mess up the node selection buttons
    case left
    case up
    case down
    case right
}

enum UILibrary {
    case both
    case tailwind(Tailwind)
    case Daisy(Daisy)
}

enum TextAlignment: String {
    case textLeft = "text-left"
    case textCenter = "text-center"
    case textRight = "text-right"
    case textJustify = "text-justify"
    case textStart = "text-start"
    case textEnd = "text-end"
}

enum TextDecoration: String, CaseIterable {
    case bold = "font-bold"
    case italic = "italic"
    case underline = "underline"
    case strikethrough = "line-through"
}
