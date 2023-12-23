//
//  ProjectFilesVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 08/07/2023.
//

import UIKit
import ReSwift

class ProjectFilesVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
    }
}

extension ProjectFilesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = "file \(indexPath.row)"
        cell.contentConfiguration = configuration
        return cell
    }
    
    
}

extension ProjectFilesVC: StoreSubscriber {
    override func viewWillAppear(_ animated: Bool) {
        ReduxStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ReduxStore.unsubscribe(self)
    }
    
    func newState(state: ReduxState) {
        
    }
}
