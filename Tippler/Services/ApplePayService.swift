//
//  ApplePayService.swift
//  Tippler
//
//  Created by Ben Baran on 5/3/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import Foundation
import PassKit

class ApplePayService{
    
    static func GenerateRequest(networks: [PKPaymentNetwork], dollarAmount: Int) -> PKPaymentRequest{
        
        let request = PKPaymentRequest()
        
        request.currencyCode = "USD"
        
        request.countryCode = "US"
        
        request.merchantIdentifier = "merchant.com.benbaran.tippler"
        
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        
        request.supportedNetworks = networks
        
        let paymentItem = PKPaymentSummaryItem.init(label: "Tippler Tip", amount: NSDecimalNumber(value: dollarAmount))
        
        request.paymentSummaryItems = [paymentItem]
        
        return request
    }
}
