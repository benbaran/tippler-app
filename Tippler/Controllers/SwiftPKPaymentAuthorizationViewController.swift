//
//  SwiftPKPaymentAuthorizationViewController.swift
//  Tippler!
//
//  Created by Ben Baran on 5/3/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//
import UIKit
import SwiftUI

struct SwiftPKPaymentAuthorizationViewController: UIViewControllerRepresentable {

    var businessId: Int
    var dollarAmount: Int
    
    func makeUIViewController(context: Context) -> UIViewController {
        return ApplePayController(businessId: self.businessId, dollarAmount: self.dollarAmount)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

