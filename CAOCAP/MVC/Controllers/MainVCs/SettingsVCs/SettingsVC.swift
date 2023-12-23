//
//  SettingsVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 10/06/2023.
//

import UIKit

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(option: SettingsOption)
    case switchCell(option: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let color: UIColor
    var isOn: Bool
    let handler: ()->Void
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let color: UIColor
    let label: String?
    let handler: ()->Void
    
    init(title: String, icon: UIImage?, color: UIColor, label: String? = nil, handler: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.color = color
        self.label = label
        self.handler = handler
    }
}

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, Storyboarded {
    var coordinator: MainCoordinator?
    
    @IBOutlet weak var tableView: UITableView!
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset.top = 40
        tableView.contentInset.bottom = 40
        tableView.register(SettingsTableViewCell.self,forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.register(SettingsSwitchTableViewCell.self,forCellReuseIdentifier: SettingsSwitchTableViewCell.identifier)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let optionType = sections[indexPath.section].options[indexPath.row]
        switch optionType.self {
        case .staticCell(let option):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
            cell.configure(with: option)
            return cell
        case .switchCell(let option):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSwitchTableViewCell.identifier, for: indexPath) as? SettingsSwitchTableViewCell else { return UITableViewCell() }
            cell.configure(with: option)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let optionType = sections[indexPath.section].options[indexPath.row]
        switch optionType.self {
        case .staticCell(let option):
            option.handler()
        case .switchCell(let option):
            option.handler()
        }
    }
                            
}

