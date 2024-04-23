//
//  BaseViewController.swift
//  basic-weather
//
//  Created by Supanat Wanroj on 23/4/2567 BE.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UIView {
    public func showLoading() {
        let loadingView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))

        loadingView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    public func hideLoading() {
        let loadingViews = self.subviews.filter { ($0 as? UIActivityIndicatorView) != nil }
        loadingViews.forEach { $0.removeFromSuperview() }
    }
}
