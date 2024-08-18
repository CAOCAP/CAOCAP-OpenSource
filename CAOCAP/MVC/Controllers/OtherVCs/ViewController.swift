//
//  ViewController.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 29/06/2024.
//

import AVKit
import AVFoundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let videoPath = Bundle.main.path(forResource: "intro", ofType: "mp4")  else { return }
        let videoPlayer = AVPlayer(url: URL(filePath: videoPath))
        let layer = AVPlayerLayer(player:  videoPlayer)
        layer.videoGravity = .resizeAspectFill
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        videoPlayer.play()
    }

}
