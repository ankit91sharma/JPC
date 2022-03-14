//
//  LoadingIndicatorViewController.swift
//  APOD
//
//  Created by Ankit Sharma on 12/03/22.
//

import Foundation
import UIKit

public protocol LoadingIndicatorViewController: AnyObject {
    var loadingIndicator: UIActivityIndicatorView? { get set }
    func showActivityIndicator(delay: Double)
    func hideActivityIndicator()
}

public struct LoadingIndicatorViewControllerHelper {
    static var loadingIndicator: UIActivityIndicatorView?
}

extension LoadingIndicatorViewController {

    var loadingIndicator: UIActivityIndicatorView? {
        get {
            return LoadingIndicatorViewControllerHelper.loadingIndicator
        } set {
            LoadingIndicatorViewControllerHelper.loadingIndicator = newValue
        }
    }
}

extension LoadingIndicatorViewController {

    func showActivityIndicator(delay: Double = 0.01) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
                let frame = UIScreen.main.bounds
                self?.loadingIndicator = UIActivityIndicatorView(frame: frame)
                self?.loadingIndicator?.backgroundColor = UIColor(white: 0, alpha: 0.5)
                self?.loadingIndicator?.style = .medium
                if let view = self?.loadingIndicator {
                    if view.traitCollection.userInterfaceStyle == UIUserInterfaceStyle.dark {
                     view.color = .white
                     view.backgroundColor = UIColor(white: 1, alpha: 0.5)
                    } else {
                        view.color = UIColor.black
                        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
                    }
                    window.addSubview(view)
                    self?.loadingIndicator?.startAnimating()
                }
               
            }
        }
    }
    
    /// hides activity indicator
    func hideActivityIndicator() {
        if loadingIndicator != nil {
            DispatchQueue.main.async { [weak self] in
                self?.loadingIndicator?.stopAnimating()
                self?.loadingIndicator?.removeFromSuperview()
                self?.loadingIndicator = nil
            }
        }
    }
    
}
