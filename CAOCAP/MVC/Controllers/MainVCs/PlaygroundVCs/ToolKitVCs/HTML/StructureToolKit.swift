//
//  StructureToolKit.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 10/08/2024.
//

import UIKit

enum SizeType {
    case none
    case small
    case medium
    case large
}

class StructureToolKit: ToolKitVC {
    
    
    var mindMap: UIMindMap!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func newState(state: ReduxState) {
        super.newState(state: state)
    }
    
    
    // MARK: - HTML Keyboard Button Actions
    /// Adds an HTML element to the current MindMap.
    ///
    /// - Parameter sender: The button that triggered this action. The button's tag determines the HTML element to add.
    @IBAction func didPressAddElement(_ sender: UIButton) {
        print("\(#function)ing...")
        // TODO: Consider externalizing the HTML tags array for better reusability.
        let htmlTags = [
            "span","canvas","div",
            "button","a","input",
            "textArea","form","label",
            "option","legend","select",
            "fieldSet","optGroup","output",
            "video","img","audio",
            "li","h1","p",
            "ul","br","hr",
        ]
        if sender.tag < htmlTags.count {
            mindMap.add(tag: htmlTags[sender.tag]) 
        }
    }
    
    
}

extension StructureToolKit: UITableViewDelegate, UITableViewDataSource {
    
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
