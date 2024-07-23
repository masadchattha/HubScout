//
//  NetworkErrorMesssage.swift
//  HubScout
//
//  Created by Muhammad Asad Chattha on 23/07/2024.
//

import Foundation

enum NetworkErrorMesssage: String {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete you request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
