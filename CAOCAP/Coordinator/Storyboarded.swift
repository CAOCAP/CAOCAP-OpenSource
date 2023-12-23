//
//  Storyboarded.swift
//  taken from AtomiCube
//
//  Created by Azzam AL-Rashed on 03/09/2022.
//
/*
 
 Storyboarded protocol lets us easily instantiate ViewControllers from a storyboard in code.
 
 Note: when adding a viewController to storyboard,
 make sure to set its storyboard identifier equal to the class name.
 
 */

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        // this pulls out "MyViewController"
        let id = String(describing: self)
        
        // load Main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // instantiate a view controller with that id(identifier), and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
