//
//  UIViewController+Ext.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 21/07/2024.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {

    func presentHSAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = HSAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle   = .crossDissolve
        self.present(alertVC, animated: true)
    }


    func presentDefaultErrorAlert() {
        let alertVC = HSAlertVC(alertTitle: "Something Went Wrong", message: "We were unable to complete your task at this time. Please try agian. ", buttonTitle: "Ok")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle   = .crossDissolve
        self.present(alertVC, animated: true)
    }


    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
