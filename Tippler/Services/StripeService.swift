//
//  StripeService.swift
//  Tippler!
//
//  Created by Ben Baran on 5/3/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import Foundation
import PassKit
import Stripe

class StripeService{
    
    static func ProcessPayment(payment: PKPayment, businessId: Int, dollarAmount: Int){
        
        #if DEBUG
        print("Processing stripe payment for business \(businessId) with amount \(dollarAmount)")
        #endif
        
        STPAPIClient.shared().createToken(with: payment) { (stripeToken, error) in
            
            guard error == nil, let stripeToken = stripeToken else {
                
                print(error!)
                
                return
            }
            
            #if DEBUG
            print("Got stripe token: \(stripeToken.tokenId)")
            #endif
            
            var json = "{\"token\": \"\(stripeToken.tokenId)\", \"businessId\": \(businessId), \"amount\": \(dollarAmount*100), \"production\": true}"
            
            #if DEBUG
            json = "{\"token\": \"\(stripeToken.tokenId)\", \"businessId\": \(businessId), \"amount\": \(dollarAmount*100),  \"production\": false}"
            #endif
            
            #if DEBUG
            print("Generated json: \(json)");
            #endif
            
            let url = URL(string: "https://tippler-api-websocket.azurewebsites.net/stripe")
            
            guard let requestUrl = url else { fatalError() }
            
            var request = URLRequest(url: requestUrl)
            
            request.httpMethod = "POST"
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = json.data(using: .utf8)
            
            #if DEBUG
            print("Calling \(url!.absoluteURL)");
            #endif
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    #if DEBUG
                    print("Error took place \(error)")
                    #endif
                    return
                }
            }
            
            #if DEBUG
            print("Sucessfully created Stripe payment");
            #endif
            
            task.resume()
        }
    }
}
