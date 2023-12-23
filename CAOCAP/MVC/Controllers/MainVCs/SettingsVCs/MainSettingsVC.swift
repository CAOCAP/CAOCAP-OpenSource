//
//  MainSettingsVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 29/06/2023.
//


import UIKit

class MainSettingsVC: SettingsVC {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            Section(title: "Main", options: [
                /*
                .staticCell(option: SettingsOption(title: "Language", icon: UIImage(systemName: "globe"), color: .systemPink, label: "English", handler: {
                    print("did press")
                    
                })),
                .staticCell(option: SettingsOption(title: "Notifications", icon: UIImage(systemName: "bell.badge.fill"), color: .systemRed, handler: {
                    print("did press")
                    
                })),
                .switchCell(option: SettingsSwitchOption(title: "Sounds", icon: UIImage(systemName: "speaker.wave.2.fill"), color: .systemOrange, isOn: false, handler: {
                    print("did press")
                    
                })),
                 */
                .staticCell(option: SettingsOption(title: "What's New?", icon: UIImage(systemName: "sparkles"), color: .systemYellow, label: "v5.0.0", handler: {
                    self.coordinator?.viewWhatsNewVC()
                    
                })),
                .staticCell(option: SettingsOption(title: "Review on AppStore", icon: UIImage(systemName: "star.bubble.fill"), color: .systemBlue, handler: {
                    guard let productURL = URL(string: "https://apps.apple.com/app/id1447742145") else { return }
                    var components = URLComponents(url: productURL, resolvingAgainstBaseURL: false)
                    components?.queryItems = [
                      URLQueryItem(name: "action", value: "write-review")
                    ]
                    guard let writeReviewURL = components?.url else { return }
                    UIApplication.shared.open(writeReviewURL)
                })),
                .staticCell(option: SettingsOption(title: "Share App", icon: UIImage(systemName: "square.and.arrow.up.fill"), color: .systemCyan, handler: {
                    guard let productURL = URL(string: "https://apps.apple.com/app/id1447742145") else { return }
                    let shareSheetVC = UIActivityViewController(activityItems: [
                        productURL
                    ], applicationActivities: nil)
                    self.present(shareSheetVC, animated: true)
                })),
            ]),
            /*
            Section(title: "contact", options: [
                .staticCell(option: SettingsOption(title: "Help", icon: UIImage(systemName: "questionmark.circle.fill"), color: .systemTeal, handler: {
                    self.coordinator?.viewHelp()
                    
                })),
                .staticCell(option: SettingsOption(title: "Support", icon: UIImage(systemName: "message.fill"), color: .systemMint, handler: {
                    self.coordinator?.viewSupport()
                    
                })),
                .staticCell(option: SettingsOption(title: "Send Feedback", icon: UIImage(systemName: "paperplane.fill"), color: .systemGreen, handler: {
                    self.coordinator?.viewSendFeedback()
                    
                })),
            ]),
            */
            Section(title: "Info", options: [
                /*
                .staticCell(option:SettingsOption(title: "Privacy Policy", icon: UIImage(systemName: "lock.shield.fill"), color: .systemGray, handler: {
                    self.coordinator?.viewPrivacyPolicy()
                    
                })),
                .staticCell(option:SettingsOption(title: "Terms Of Use", icon: UIImage(systemName: "doc.on.clipboard.fill"), color: .systemGray, handler: {
                    self.coordinator?.viewTermsOfUse()
                    
                })),
                 */
                .staticCell(option:SettingsOption(title: "About Us", icon: UIImage(systemName: "info.circle.fill"), color: .systemGray2, handler: {
                    self.coordinator?.viewAboutUs()
                    
                })),
                .staticCell(option: SettingsOption(title: "Credits", icon: UIImage(systemName: "person.2.fill"), color: .systemGray3, handler: {
                    self.coordinator?.viewCredits()
                    
                })),
            ]),
        ]
        
    }

}

