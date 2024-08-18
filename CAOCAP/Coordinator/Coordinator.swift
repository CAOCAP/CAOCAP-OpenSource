//
//  Coordinator.swift
//  taken from AtomiCube
//
//  Created by Azzam AL-Rashed on 03/09/2022.
//
/*
 
 Using the coordinator pattern lets us remove the job of app navigation
 from viewControllers, helping make them more manageable and more reusable.
 
 */

import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    
    /// Array to keep tracking of all child coordinators. Most of the time this array will contain only one child coordinator
    var childCoordinators: [Coordinator] { get set }
    
    /// A place to put logic to start the flow.
    func start()
    
    init()
}
