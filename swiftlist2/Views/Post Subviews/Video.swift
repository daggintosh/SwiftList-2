//
//  Video.swift
//  swiftlist2
//
//  Created by Dagg on 6/13/23.
//

import AVKit
import SwiftUI

struct GifView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    let url: URL?
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }

    func makeUIView(context: Context) -> UIView {
        if let url {
            return PlayerView(frame: .zero, url: url)
        } else {
            return UIView(frame: .zero)
        }
    }
}

struct VideoView: UIViewControllerRepresentable {
    typealias UIViewControllerType = AVPlayerViewController
    
    let url: URL?
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let uiViewController = AVPlayerViewController()
        if let url {
            uiViewController.allowsPictureInPicturePlayback = true
            uiViewController.showsPlaybackControls = true
            let player = AVPlayer(url: url)
            uiViewController.player = player
        }
        return uiViewController
    }
}

class PlayerView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var looper: AVPlayerLooper? = nil
    
    required init(frame: CGRect, url: URL) {
        super.init(frame: frame)
        let playerItem = AVPlayerItem(url: url)
        let playerQueue = AVQueuePlayer(playerItem: playerItem)

        self.looper = AVPlayerLooper(player: playerQueue, templateItem: playerItem)
        playerQueue.play()
        
        playerLayer.player = playerQueue
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playerLayer.frame = bounds
    }
}
