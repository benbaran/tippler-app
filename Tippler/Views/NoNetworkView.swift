//
//  NoNetworkView.swift
//  Tippler
//
//  Created by Ben Baran on 5/3/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import SwiftUI

struct NoNetworkView: View {
    var body: some View {
        
        VStack{
            Text("Tippler requires an Internet connection. Please turn on WiFi or Cellular data to continue.")
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            
            
        }
    }
}

struct NoNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NoNetworkView()
    }
}
