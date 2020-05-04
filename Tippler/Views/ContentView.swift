//
//  ContentView.swift
//  Tippler
//
//  Created by Ben Baran on 5/3/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import SwiftUI
import Network

struct ContentView: View {
    
    let monitor = NWPathMonitor()
    
    let queue = DispatchQueue(label: "Monitor")
    
    @State private var hasInternetConnection = true;
    
    var body: some View {
        
        self.monitor.pathUpdateHandler = { path in
            
            if path.status == .satisfied {
                
                print("We're connected!")
                
                self.hasInternetConnection = true;
                
            }
            else {
                
                print("No connection.")
                
                self.hasInternetConnection = false;
            }
        }
        
        // Handle Network Changes
        self.monitor.start(queue: self.queue)
        
        return (VStack{
            
            if(self.hasInternetConnection == false){
                
                NoNetworkView()
            }
            else{
                
                MainView()
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
