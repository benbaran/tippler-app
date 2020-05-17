//
//  GoalView.swift
//  Tippler
//
//  Created by Ben Baran on 5/9/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import SwiftUI

struct GoalMetView: View {
    
    var amount: CGFloat
    
    var goal: CGFloat
    
    var width = CGFloat(UIScreen.main.bounds.size.width);
    
    
    var body: some View {
        
        VStack{
            Text("$\(Int(amount)) Tipped this Week").foregroundColor(Color.green).font(.headline).padding(.top)
            Text("Weekly Goal of $\(Int(goal)) Met!").foregroundColor(Color.green).font(.subheadline).padding(.top)
        }
    }
}

struct GoalNotMetView: View {
    
    var amount: CGFloat
    
    var goal: CGFloat
    
    var width = CGFloat(UIScreen.main.bounds.size.width);
    
    var body: some View {
        
        VStack{
            Text("Weekly Goal")
                .padding(.top)
                .font(.headline)
        
        ZStack{
            
            HStack{
                
                Rectangle()
                    .fill(Color.green)
                    .frame(
                        width: amount > goal ? (width) : width * (amount / goal),
                        height: 28
                )
                .padding(3)
                
                Spacer()
            }
            .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .padding(5)
            
            Text("$\(Int(amount)) of $\(Int(goal))")
        }
    }
    }
}

struct GoalView: View {
    
    var amount: Int;
    
    var goal = CGFloat(100);
    
    var width = CGFloat(UIScreen.main.bounds.size.width);
    
    var body: some View {
        
        let floatAmount = CGFloat(amount)
        
        return (
            
            VStack{
                
                if(floatAmount >= goal){
                    
                    GoalMetView(amount: floatAmount, goal: goal)
                }
                else{
                    
                    GoalNotMetView(amount: floatAmount, goal: goal)
                }
        }
        )
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
