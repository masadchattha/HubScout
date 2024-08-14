//
//  UIView+Ext.swift
//  HubScout
//
//  Created by o9tech on 14/08/2024.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
