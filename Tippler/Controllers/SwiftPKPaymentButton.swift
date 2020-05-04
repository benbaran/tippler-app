//
//  SwiftPKPaymentButton.swift
//  Tippler!
//
//  Created by Ben Baran on 5/3/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import SwiftUI
import PassKit

struct SwiftPKPaymentButton: UIViewRepresentable {
     
    
    func updateUIView(_ uiView: PKPaymentButton, context: Context) {

    }
    
    
    typealias UIViewType = PKPaymentButton
    
    func makeUIView(context: Context) -> PKPaymentButton {
         return PKPaymentButton()
     }
}

struct SwiftPKPaymentButton_Previews: PreviewProvider {
    static var previews: some View {
        SwiftPKPaymentButton()
    }
}
