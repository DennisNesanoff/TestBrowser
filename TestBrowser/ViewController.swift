//
//  ViewController.swift
//  TestBrowser
//
//  Created by Dennis Nesanoff on 20.04.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var forwardButton: UIButton!
    @IBOutlet var urlTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTextField.delegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        
        loadHomePage()
    }

    private func loadHomePage() {
        let homePage = "https://www.apple.com"
        guard let url = URL(string: homePage) else { return }
        let request = URLRequest(url: url)
        urlTextField.text = homePage
        webView.load(request)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonAction(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text
        if let url = URL(string: urlString!) {
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            loadHomePage()
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlTextField.text = webView.url?.absoluteString
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
