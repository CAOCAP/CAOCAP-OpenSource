//
//  Challenge.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 08/08/2023.
//

import Foundation

class Challenge {
    let title: String
    let description: String
    let regex: Regex<(Substring, Substring, Substring)>
    var isComplete: Bool
    
    init(title: String, description: String, regex: Regex<(Substring, Substring, Substring)>, isComplete: Bool = false) {
        self.title = title
        self.description = description
        self.regex = regex
        self.isComplete = isComplete
    }
}
