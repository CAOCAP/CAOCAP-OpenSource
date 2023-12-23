//
//  ISOLanguageCodeCell.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 25/07/2023.
//

import UIKit

class ISOLanguageCodeCell: UITableViewCell {
    static let identifier = "ISOLanguageCodeCell"
    var language = ""
    var code = ""
    

    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        selectionStyle = .none
        var content = defaultContentConfiguration().updated(for: state)
        content.text = language
        content.secondaryText = code
        if state.isSelected {
            accessoryType = .checkmark
        } else {
            accessoryType = .none
        }

        contentConfiguration = content
        
    }

}
