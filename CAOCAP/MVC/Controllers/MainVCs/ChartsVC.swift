//
//  ChartsVC.swift
//  taken from AtomiCube
//
//  Created by Azzam AL-Rashed on 15/09/2022.
//

import UIKit
import SwiftUI

// MARK: ChartsVC will use SwiftUI & Charts

class ChartsVC: ContainerVC, Storyboarded {
    var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [UIHostingController(rootView: UIDashboardView())]
        
    }

}
