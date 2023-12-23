//
//  ContainerVC.swift
//  taken from AtomiCube
//
//  Created by Azzam AL-Rashed on 14/09/2022.
//

import UIKit

/// A UIViewController that can contain an array of UIViewControllers.
/// you can use this to contain SwiftUI views using UIHostingController
///
class ContainerVC: UIViewController {

    var container = UIView(frame: .zero)
    var viewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container.frame = view.bounds
        view.insertSubview(container, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubViewControllers()
    }
    
    func addSubViewControllers() {
        for viewController in viewControllers {
            viewController.view.frame = view.bounds
            container.addSubview(viewController.view)
            addChild(viewController)
            viewController.didMove(toParent: self)
        }
    }

}
