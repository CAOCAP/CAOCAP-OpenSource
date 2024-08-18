//
//  ToolKitVC.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 10/08/2024.
//

import UIKit
import ReSwift

class ToolKitCollection {
    
    var currentIndex = 1
    var previousIndex = 1
    let viewControllers: [ToolKitVC]
    
    init(viewControllers: [ToolKitVC]) {
        self.viewControllers = viewControllers
    }
    
}

class ToolKitVC: UIViewController, StoreSubscriber, Storyboarded {

    
    /// The current project being edited in the playground.
    var project: Project?
    
    //MARK: Outlets
    @IBOutlet weak var toolKitStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /// Subscribes to the Redux store when the view appears.
    override func viewWillAppear(_ animated: Bool) {
        ReduxStore.subscribe(self)
    }
    
    /// Unsubscribes from the Redux store when the view disappears.
    override func viewWillDisappear(_ animated: Bool) {
        ReduxStore.unsubscribe(self)
    }
    
    /// Updates the UI based on the new state from the Redux store.
    ///
    /// - Parameter state: The new state from the Redux store.
    func newState(state: ReduxState) {
        updateProjectIfNeeded(from: state)
    }
    
    // MARK: - Helper Functions
    
    /// Updates the project reference if it is not already set.
    ///
    /// - Parameter state: The new state from the Redux store.
    private func updateProjectIfNeeded(from state: ReduxState) {
        if project == nil {
            project = state.openedProject
        }
    }

    
    /// Changes the view displayed based on the selected segment in the AttributesView segmented control.
    ///
    /// - Parameter sender: The segmented control that triggered this action.
    @IBAction func didChangeToolKitSegmentedControl(_ sender: UISegmentedControl) {
        toolKitStackView.arrangedSubviews.enumerated().forEach { index, view in
            if index != 0 { view.isHidden = index != (sender.selectedSegmentIndex + 1) }
        }
    }

}
