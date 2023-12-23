//
//  CreditsVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 21/07/2023.
//

import UIKit

struct Credits {
    let title: String
    let contributors: [(name: String, profession: String?, url: String?)]
}

class CreditsVC: UIViewController, Storyboarded, UITableViewDelegate, UITableViewDataSource {
    var coordinator: MainCoordinator?
    
    @IBOutlet weak var tableView: UITableView!
    var credits = [
        Credits(title: "C-Squad", contributors: [
            (name: "Azzam Al-Rashed", profession: "Software Engineer", url: "https://twitter.com/azzam_rar"),
            (name: "Meshal Al-Fiez", profession: "Digital Artist", url: nil),
            (name: "Anas Al-Qassim", profession: "Software Engineer", url: "https://www.linkedin.com/in/anas-alqassim-b1190b209"),
            (name: "Omar Al-Zahrani", profession: "Software Engineer", url: "https://twitter.com/azx0_o"),
            (name: "Mshari Al-Zahrani", profession: "Software Engineer", url: "https://mshari.net"),
            (name: "Feras Al-Nowiser", profession: "Software Engineer", url: "https://twitter.com/FerasNr"),
            (name: "Muhammad Al-Mujtaba", profession: "Software Engineer", url: nil),
            (name: "Faisal Al-Thuwaini", profession: "Digital Artist", url: "https://www.linkedin.com/in/faisal-al-thuwaini"),
            (name: "Saleh Al-Thini", profession: "Software Engineer", url: "https://twitter.com/salehalthini"),
            (name: "Ibrahim Al-Jumaiah", profession: nil, url: nil),
            (name: "Ahmed Al-Helali", profession: "Software Engineer", url: "https://twitter.com/ahmed__alhelali"),
        ]),
        
        Credits(title: "Special Thanks", contributors: [
            (name: "Mom", profession: nil, url: nil),
            (name: "Dad", profession: nil, url: nil),
        ]),
        
        Credits(title: "Third Party Code", contributors: [
            (name: "SwiftSoup", profession: "HTML Parser", url: "https://github.com/scinfu/SwiftSoup"),
            (name: "ReSwift", profession: "Unidirectional Data Flow", url: "https://github.com/ReSwift/ReSwift"),
            (name: "SnapKit", profession: "Autolayout DSL", url: "https://github.com/SnapKit/SnapKit"),
            (name: "Popovers", profession: "Simple, modern, and highly customizable Popovers", url: "https://github.com/aheze/Popovers"),
            (name: "Firebase", profession: "Backend", url: "https://firebase.google.com"),
            (name: "Realm", profession: "Data storage", url: "https://realm.io/realm-swift/"),
            (name: "Lottie", profession: "Animation", url: "https://airbnb.design/lottie/"),
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset.top = 40
        tableView.contentInset.bottom = 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return credits.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credits[section].contributors.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return credits[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "creditCell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = credits[indexPath.section].contributors[indexPath.row].name
        configuration.secondaryText = credits[indexPath.section].contributors[indexPath.row].profession
        cell.contentConfiguration = configuration
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = credits[indexPath.section].contributors[indexPath.row].url,
              let url = URL(string: urlString) else { return }
            UIApplication.shared.open(url)
    }
    
}
