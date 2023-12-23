//
//  NavigationVC.swift
//  taken from AtomiCube
//
//  Created by Azzam AL-Rashed on 14/09/2022.
//

import UIKit

class NavigationVC: ContainerVC, Storyboarded {
    var coordinator: MainCoordinator?

    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var glowView: UIView!
    @IBOutlet weak var glowViewLeadingConstraint: NSLayoutConstraint!
    var indicatorColor: UIColor = .systemBlue
    
    @IBOutlet var navigationButtons: [UIButton]!
    @IBOutlet var navigationButtonViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigate(to: 0)
        glowView.backgroundColor = indicatorColor
        indicatorView.backgroundColor = indicatorColor
        for (index, button) in navigationButtons.enumerated() {
            button.tag = index
        }
    }
    
    func navigate(to selectedIndex: Int, animated: Bool = false) {
        var views = viewControllers.map(\.view)
        let selectedView = views.remove(at: selectedIndex)
        for unselectedView in views { unselectedView?.isHidden = true }
        selectedView?.isHidden = false
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.glowViewLeadingConstraint.constant = self.navigationButtonViews[selectedIndex].frame.minX
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    
    @IBAction func didPressNavigationButton(_ sender: UIButton) {
        if sender.tag < viewControllers.count {
            navigate(to: sender.tag, animated: true)
        }
    }
    
    @IBAction func didPressPlusButton(_ sender: UIButton) {
        coordinator?.createNewProject()
    }
    
    
}
