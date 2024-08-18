//
//  LibraryCollectionViewCell.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 09/07/2023.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func configure(title: String) {
        label.text = title
    }
}
