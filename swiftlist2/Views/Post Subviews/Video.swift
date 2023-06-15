//
//  Video.swift
//  swiftlist2
//
//  Created by Dagg on 6/13/23.
//

import AVKit
import SwiftUI

struct VideoView: UIViewControllerRepresentable {
    typealias UIViewControllerType = AVPlayerViewController
    
    let url: URL?
    var fakeGif: Bool = false // Fake gif? Remove the controls and autoplay!
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
//    @objc func fakeGifListenToMe(player: AVPlayer) {
//        player.seek(to: CMTime.zero)
//    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let uiViewController = AVPlayerViewController()
        if let url {
            uiViewController.allowsPictureInPicturePlayback = true
            uiViewController.showsPlaybackControls = !fakeGif
            let player = AVPlayer(url: url)
            uiViewController.player = player
            if (fakeGif) {
                player.play()
            }
        }
        return uiViewController
    }
}
