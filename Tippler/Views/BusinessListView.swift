//
//  BusinessListView.swift
//  Tippler!
//
//  Created by Ben Baran on 5/3/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import SwiftUI

struct BusinessListView: View {
    
    var businesses: [Business]
    
    var body: some View {
            List(businesses, id: \.id) { business in
                
                HStack{
                    
                    NavigationLink(destination: PayView(businessId: business.id, businessName: business.name)){
                        
                    Text(business.name)
                    
                    Spacer()
                    
                    Text("$\(business.amount)")
                    }
                }
            }
    }
}

struct BusinessListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
    }
}
