//
//  ConActToolKit.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 11/08/2024.
//


import UIKit

class ConActToolKit: ToolKitVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func newState(state: ReduxState) {
        super.newState(state: state)
    }
    
    /// Handles the addition of an action node in the JS MindMap.
    @IBAction func didPressAddAction(_ sender: UIButton) {
        print("\(#function)ing...")
        // TODO: Implement action node addition logic.
    }
    
    /// Handles the addition of a condition node in the JS MindMap.
    @IBAction func didPressAddCondition(_ sender: UIButton) {
        print("\(#function)ing...")
        // TODO: Implement condition node addition logic.
    }
}


extension ConActToolKit: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Components"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
