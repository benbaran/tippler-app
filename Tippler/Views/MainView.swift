//
//  MainView.swift
//  Tippler!
//
//  Created by Ben Baran on 5/3/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    let defaults = UserDefaults.standard
    
    let timer = Timer.publish(every: 5, on: .current, in: .common).autoconnect()
    
    @State private var businesses = [Business]()
    
    @State private var businessId: Int = 1
    
    @State private var weeklyAmount = 0;
    
    var body: some View {
        
        
        NavigationView{
            
            VStack{
                
                LogoView().padding(.horizontal)
                
                GoalView(amount: self.weeklyAmount)
                
                BusinessListView(businesses: self.businesses)
            }
        }
        .onAppear(){
            self.loadBusinesses();
            
        }
        .onReceive(timer, perform: {
            _ in
            self.loadBusinesses()
        })
        
        
        
        
        
    }
    
    func loadWeeklyAmount(){
        
        DataService.getWeekTips { result in
            
            switch result {
                
            case .failure(let error):
                print(error)
                
            case .success(let amount):
                self.weeklyAmount = amount
            }
        }
    }
    
    func loadBusinesses(){
        
        DataService.getBusinesses { result in
            
            switch result {
                
            case .failure(let error):
                print(error)
                
            case .success(let businesses):
                self.businesses = businesses
            }
        }
        
        loadWeeklyAmount()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
