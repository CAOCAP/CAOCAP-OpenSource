//
//  EventsToolKit.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 10/08/2024.
//

import UIKit

class EventsToolKit: ToolKitVC {
    
    
    //MARK: JS Keyboard Outlets
    @IBOutlet weak var logicKeyboardView: UIView!
    @IBOutlet weak var logicStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func newState(state: ReduxState) {
        super.newState(state: state)
    }
    
    /// Handles the addition of an event node in the JS MindMap.
    @IBAction func didPressAddEvent(_ sender: UIButton) {
        print("\(#function)ing...")
        // TODO: Implement event node addition logic.
    }
}
