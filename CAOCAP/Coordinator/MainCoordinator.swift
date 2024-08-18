//
//  MainCoordinator.swift
//  taken from AtomiCube
//
//  Created by Azzam AL-Rashed on 03/09/2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    static let shared = MainCoordinator()
    
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    
    internal init() {}
    
    //MARK: Initial View Controller
    func start() {
        let navigationVC = NavigationVC.instantiate()
        
        navigationVC.viewControllers = [HomeVC.instantiate(),
                                        ChartsVC.instantiate(),
                                        ProjectsListVC.instantiate(),
                                        MainSettingsVC.instantiate()]
        
        navigationController.pushViewController(navigationVC, animated: false)
    }
    
    
    
    //MARK: Home
    func viewPurchase() {
        let vc = PurchaseVC.instantiate()
        navigationController.present(vc, animated: true)
    }
    
    func viewWorld() {
        let vc = WorldVC.instantiate()
        navigationController.present(vc, animated: true)
    }
    
    func viewStore() {
        let vc = StoreVC.instantiate()
        navigationController.present(vc, animated: true)
    }
    
    func viewCoCaptain() {
        let vc = CoCaptainVC.instantiate()
        navigationController.present(vc, animated: true)
    }
    
    func viewPalette() {
        let vc = PaletteVC.instantiate()
        navigationController.present(vc, animated: true)
    }
    
    func createNewProject() {
        ReduxStore.dispatch(CreateProjectAction(newProject: Project()))
        let vc = PlaygroundVC.instantiate()
        navigationController.present(vc, animated: true)
    }
    
    
    //MARK: Main Settings
    func viewCredits() {
        let vc = CreditsVC.instantiate()
        navigationController.present(vc, animated: true)
    }
    
    func viewAboutUs() {
        let vc = AboutUsVC.instantiate()
        navigationController.present(vc, animated: true)
    }
    
    func viewTermsOfUse() {
        let vc = TermsOfUseVC()
        navigationController.present(vc, animated: true)
    }
    
    func viewPrivacyPolicy() {
        let vc = PrivacyPolicyVC()
        navigationController.present(vc, animated: true)
    }
    
    func viewSendFeedback() {
        let vc = SendFeedbackVC()
        navigationController.present(vc, animated: true)
    }
    
    func viewSupport() {
        let vc = SupportVC()
        navigationController.present(vc, animated: true)
    }
    
    func viewHelp() {
        let vc = HelpVC()
        navigationController.present(vc, animated: true)
    }
    
    func viewWhatsNewVC() {
        let vc = WhatsNewVC.instantiate()
        navigationController.present(vc, animated: true)
    }
    
}
