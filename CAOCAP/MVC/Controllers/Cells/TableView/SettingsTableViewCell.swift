//
//  SettingsTableViewCell.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 29/06/2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    static let identifier = "SettingTableViewCell"
    
    private let colorView: UIView = {
       let view = UIView()
        view.clipsToBounds = true
        view.cornerRadius = 8
        return view
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 1
        return title
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(label)
        contentView.addSubview(colorView)
        colorView.addSubview(iconView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    public func configure(with option: SettingsOption) {
        colorView.backgroundColor = option.color
        iconView.image = option.icon
        title.text = option.title
        label.text = option.label
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        fatalError("SettingsTableViewCell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        colorView.frame = CGRect(x: 15, y: 6, width: size, height: size)
        let iconSize: CGFloat = size/1.5
        iconView.frame = CGRect(x: (size-iconSize)/2, y: (size-iconSize)/2, width: iconSize, height: iconSize)
        
        stackView.frame = CGRect(
            x: colorView.frame.width + 25,
            y: 0,
            width: contentView.frame.width - colorView.frame.width - 35,
            height: contentView.frame.height
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        colorView.backgroundColor = nil
        iconView.image = nil
        label.text = nil
    }

}
