//
//  WebView.swift
//  swiftlist2
//
//  Created by Dagg on 6/14/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    typealias UIViewControllerType = WKWebView

    var url: URL?
    var content: String?
    
    func makeUIView(context: Context) -> WKWebView {
        let controllerConfiguration = WKWebViewConfiguration()
        controllerConfiguration.allowsInlineMediaPlayback = true
        controllerConfiguration.allowsPictureInPictureMediaPlayback = true
        controllerConfiguration.allowsAirPlayForMediaPlayback = true

        let overrideViewport = WKUserScript(source: #"document.head.innerHTML = document.head.innerHTML + `\n<meta name="viewport" content="width=device-width user-scalable=no">\n<style>img { pointer-events: none; } * { -webkit-user-select:none; }</style>`; document.body.style.margin = 0"#, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let ucController = WKUserContentController()
        ucController.addUserScript(overrideViewport)

        controllerConfiguration.userContentController = ucController

        let controller = WKWebView(frame: .init(), configuration: controllerConfiguration)
        controller.allowsBackForwardNavigationGestures = false
        controller.isOpaque = false
        controller.scrollView.isScrollEnabled = false

        if let url {
            var request = URLRequest(url: url)
            request.setValue("https://youtube.com", forHTTPHeaderField: "Origin") // Bypass allowed Origins, only seems to affect YouTube
            controller.load(request)
        }
        if let content {
            controller.loadHTMLString(content, baseURL: nil)
        }
        return controller
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
