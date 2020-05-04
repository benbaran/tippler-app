//
//  ApplePayController.swift
//  Tippler!
//
//  Created by Ben Baran on 5/3/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import Foundation
import UIKit
import PassKit

class ApplePayController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
    
    var businessId: Int
    
    var dollarAmount: Int
    
    init(businessId: Int, dollarAmount: Int) {
        
        self.dollarAmount = dollarAmount
        
        self.businessId = businessId
        
        super.init(nibName: (nil), bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        
        let networks = [PKPaymentNetwork.amex, .discover, .masterCard, .visa]
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: networks)
        {
            
            let request = ApplePayService.GenerateRequest(networks: networks, dollarAmount: dollarAmount)
            
            guard let view = PKPaymentAuthorizationViewController(paymentRequest: request)
                
                else {
                    
                    displayDefaultAlert(title: "Error", message: "Unable to present Apple Pay authorization.")
                    
                    return
            }
            
            view.delegate = self
            
            self.present(view, animated: true, completion: nil)
            
        }
        else
        {
            
            displayDefaultAlert(title: "Error", message: "Unable to make Apple Pay transaction.")
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
     
        self.dismiss(animated: true, completion: nil)
        
         self.parent?.dismiss(animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        #if DEBUG
             print("Processing apple pay payment for business \(businessId) with amount \(dollarAmount)")
        #endif
        
        StripeService.ProcessPayment(payment: payment, businessId: self.businessId, dollarAmount: self.dollarAmount)
        
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        
       
    }
    
    func displayDefaultAlert(title: String?, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
