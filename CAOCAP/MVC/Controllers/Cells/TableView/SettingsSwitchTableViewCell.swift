//
//  SettingsSwitchTableViewCell.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 29/06/2023.
//

import UIKit

class SettingsSwitchTableViewCell: UITableViewCell {
    static let identifier = "SettingsSwitchTableViewCell"
    
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
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let toggle: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(toggle)
        contentView.addSubview(colorView)
        colorView.addSubview(iconView)
        contentView.clipsToBounds = true
    }
    
    public func configure(with option: SettingsSwitchOption) {
        colorView.backgroundColor = option.color
        toggle.onTintColor = option.color
        toggle.isOn = option.isOn
        iconView.image = option.icon
        label.text = option.title
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
        
        toggle.sizeToFit()
        toggle.frame.origin = CGPoint(x: contentView.frame.width - toggle.frame.width - 20, y: (contentView.frame.height - toggle.frame.height)/2)
        
        
        label.frame = CGRect(
            x: colorView.frame.width + 25,
            y: 0,
            width: contentView.frame.width - colorView.frame.width - 25,
            height: contentView.frame.height
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        colorView.backgroundColor = nil
        iconView.image = nil
        label.text = nil
        toggle.isOn = false
    }

}
