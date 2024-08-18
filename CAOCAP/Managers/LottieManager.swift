//
//  LottieManager.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 16/07/2023.
//

import UIKit
import Lottie

/// Enum representing different types of animations that can be played.
/// The raw value of each case corresponds to the name of the Lottie animation file.
enum AnimationType: String {
    case confetti
    case party
}

/// `LottieManager` is a singleton class that provides utility methods for creating and managing
/// Lottie animations within the CAOCAP app. It simplifies the creation and configuration of
/// Lottie animation views.
final class LottieManager {
    
    /// The shared singleton instance of `LottieManager`, allowing centralized access to animation utilities.
    static let shared = LottieManager()
    
    /// Private initializer to enforce singleton pattern.
    private init() {}
    
    /// Creates and configures a `LottieAnimationView` with the specified animation type and options.
    ///
    /// - Parameters:
    ///   - type: The type of animation to be played, represented by the `AnimationType` enum.
    ///   - contentMode: The content mode for the animation view. Defaults to `.scaleAspectFit`.
    ///   - loopMode: The looping behavior of the animation. Defaults to `.playOnce`.
    ///   - speed: The playback speed of the animation. Defaults to `1.0`.
    /// - Returns: A configured `LottieAnimationView` ready to be added to a view hierarchy.
    func createAnimationView(type: AnimationType, contentMode: UIView.ContentMode = .scaleAspectFit, loopMode: LottieLoopMode = .playOnce, speed: CGFloat = 1) -> LottieAnimationView {
        let animationView = LottieAnimationView(name: type.rawValue)
        configure(animationView: animationView, contentMode: contentMode, loopMode: loopMode, speed: speed)
        return animationView
    }
    
    /// Adds and plays a Lottie animation on a specified view, with options for customization.
    ///
    /// - Parameters:
    ///   - view: The view on which the animation will be added and played.
    ///   - type: The type of animation to be played, represented by the `AnimationType` enum.
    ///   - contentMode: The content mode for the animation view. Defaults to `.scaleAspectFit`.
    ///   - loopMode: The looping behavior of the animation. Defaults to `.playOnce`.
    ///   - speed: The playback speed of the animation. Defaults to `1.0`.
    ///
    /// This method adds the configured `LottieAnimationView` as a subview to the specified view, plays the animation,
    /// and automatically removes the animation view from the superview once the animation completes.
    func playAnimation(on view: UIView, type: AnimationType, contentMode: UIView.ContentMode = .scaleAspectFit, loopMode: LottieLoopMode = .playOnce, speed: CGFloat = 1) {
        let animationView = createAnimationView(type: type, contentMode: contentMode, loopMode: loopMode, speed: speed)
        animationView.frame = view.bounds
        view.addSubview(animationView)
        animationView.play { _ in
            animationView.removeFromSuperview()
        }
    }
    
    /// Configures a `LottieAnimationView` with specified options.
    ///
    /// - Parameters:
    ///   - animationView: The `LottieAnimationView` instance to be configured.
    ///   - contentMode: The content mode for the animation view.
    ///   - loopMode: The looping behavior of the animation.
    ///   - speed: The playback speed of the animation.
    private func configure(animationView: LottieAnimationView, contentMode: UIView.ContentMode, loopMode: LottieLoopMode, speed: CGFloat) {
        animationView.isUserInteractionEnabled = false
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        animationView.animationSpeed = speed
    }
}
