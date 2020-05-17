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
    
    @State private var favorites = [Business]()
    
    @State private var favoriteUserDefaults = [Int]()
    
    @State private var others = [Business]()
    
    let timer = Timer.publish(every: 0.5, on: .current, in: .common).autoconnect()

    var body: some View {
        
        VStack{
            
            List {
                Section(header: Text("Favorites")) {
                    
                    if(favorites.count == 0){
                        
                        Text("No Favorites")
                    }
                    else{
                        ForEach(favorites, id: \.self) { favorite in
                            
                            NavigationLink(destination: PayView(businessId: favorite.id, businessName: favorite.name, businessWebsite: favorite.website)) {
                                
                                HStack{
                                    
                                    Button(
                                        action: {},
                                        label: {Image(systemName: "heart.fill")}
                                    ).foregroundColor(.red)
                                        .onTapGesture {
                                            
                                            self.favorites = self.favorites.filter {$0 != favorite}
                                            
                                            self.favoriteUserDefaults = self.favoriteUserDefaults.filter {$0 != favorite.id}
                                            
                                            #if DEBUG
                                            print(self.favoriteUserDefaults)
                                            #endif
                                            
                                            let defaults = UserDefaults.standard
                                            
                                            defaults.set(self.favoriteUserDefaults, forKey: "UserFavorites")
                                    }
                                    
                                    Text("\(favorite.name)")
                                    
                                    Spacer()
                                    
                                    Text("$\(favorite.amount)")
                                    
                                }
                            }
                        }
                    }
                    
                    
                }
                
                Section(header: Text("All")) {
                    
                    ForEach(businesses, id: \.self) { business in
                        
                        NavigationLink(destination: PayView(businessId: business.id, businessName: business.name, businessWebsite: business.website)) {
                            HStack{
                                
                                Button(
                                    action: {},
                                    label: {Image(systemName: "heart")}
                                )
                                    .onTapGesture {
                                        
                                        if(!self.favorites.contains(business)){
                                            
                                            self.favorites.append(business)
                                            
                                            if(!self.favoriteUserDefaults.contains(business.id)){
                                                
                                                self.favoriteUserDefaults.append(business.id)
                                            }
                                            
                                            #if DEBUG
                                            print(self.favoriteUserDefaults)
                                            #endif
                                            
                                            let defaults = UserDefaults.standard
                                            
                                            defaults.set(self.favoriteUserDefaults, forKey: "UserFavorites")
                                        }
                                }
                                
                                Text("\(business.name)")
                                
                                Spacer()
                                
                                Text("$\(business.amount)")
                                
                            }
                        }
                    }
                }
            }
        }.onReceive(timer, perform: {
            _ in
            
            #if DEBUG
            print(self.businesses)
            #endif
            
            let defaults = UserDefaults.standard
            
            self.favoriteUserDefaults = defaults.array(forKey: "UserFavorites")  as? [Int] ?? [Int]()
            
            #if DEBUG
            print("Found \(self.favoriteUserDefaults.count) user defaults.")
            
            print(self.favoriteUserDefaults)
            #endif
            
            for business in self.businesses {
             
                if(self.favoriteUserDefaults.contains(business.id) && !self.favorites.contains(business)){
            
                    self.favorites.append(business)
                }
            }
            
            if(self.businesses.count > 0){
            
                self.timer.upstream.connect().cancel()
            }
        })
    }
}

struct BusinessListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
    }
}
