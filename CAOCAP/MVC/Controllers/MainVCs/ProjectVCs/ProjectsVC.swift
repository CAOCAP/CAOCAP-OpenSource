//
//  ProjectsVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 10/06/2023.
//

import UIKit

class ProjectCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!
}

class ProjectsVC: UIViewController, Storyboarded {
    var coordinator: MainCoordinator?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset.bottom = 40
    }
}

extension ProjectsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProjectCell else { return UITableViewCell() }
        
        cell.title.text = "error: failed to load project name"
        cell.lastUpdated.text = Date.now.formatted()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("error: failed to load project")
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { (_, _, _) in
            print("error: failed to delete project")
        }
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        return swipeActionConfig
    }
}
