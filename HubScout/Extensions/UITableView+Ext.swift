//
//  UITableView+Ext.swift
//  HubScout
//
//  Created by o9tech on 14/08/2024.
//

import UIKit

extension UITableView {

    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
}
