//
//  MainCoordinatorVC.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 17/08/2024.
//

import UIKit

/// An extension to `UIViewController` that provides a default `coordinator` property.
/// This property is read-only and returns the shared instance of `MainCoordinator`.
extension UIViewController {
    
    /// A read-only computed property that returns the default `Coordinator`,
    /// which is `MainCoordinator.shared`. This property provides access to the
    /// main coordinator for handling navigation and flow within the app.
    ///
    /// - Note: The `coordinator` property is immutable and cannot be modified.
    var coordinator: MainCoordinator {
        return MainCoordinator.shared
    }
}
