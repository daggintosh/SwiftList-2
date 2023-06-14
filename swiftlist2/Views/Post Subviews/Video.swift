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
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        var uiViewController = AVPlayerViewController()
        if let url {
            uiViewController.allowsPictureInPicturePlayback = true
            uiViewController.showsPlaybackControls = true
            uiViewController.player = AVPlayer(url: url)
        }
        return uiViewController
    }
}
