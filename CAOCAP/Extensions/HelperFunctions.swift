//
//  HelperFunctions.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 14/08/2024.
//

import UIKit


// MARK: - URL Handling
// Function to open a URL in Safari
func openURLInSafari(urlString: String) {
    // Try to create a URL object from the provided string
    if let url = URL(string: urlString) {
        // If the URL object is valid, use UIApplication to open it in Safari
        // The 'options' parameter is usually an empty dictionary, and 'completionHandler' is optional
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
        // If the URL string is invalid, print an error message for debugging purposes
        print("Invalid URL string: \(urlString)")
    }
}
