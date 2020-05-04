//
//  PayView.swift
//  Tippler!
//
//  Created by Ben Baran on 5/3/20.
//  Copyright © 2020 Ben Baran. All rights reserved.
//

import SwiftUI
import PassKit

class TipButtonStyle: ButtonStyle{
    
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .frame(maxWidth: 50, maxHeight: 50)
            .font(.largeTitle)
            .padding(10)
            .foregroundColor(Color.green)
            .overlay(
                Circle()
                    .stroke(Color.green, lineWidth: 3)
        )
            .padding(20)
            .scaleEffect(configuration.isPressed ? 1.3 : 1)
    }
}

class SelectedButtonStyle: ButtonStyle{
    
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .frame(maxWidth: 50, maxHeight: 50)
            .font(.largeTitle)
            .padding(10)
            .foregroundColor(Color.white)
            .background(Color.green)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.green, lineWidth: 3)
        )
            .padding(20)
            .scaleEffect(configuration.isPressed ? 1.3 : 1)
    }
}

struct PayView: View {
    
    var businessId: Int
    
    var businessName: String
    
    @State var paymentSheetShown = false;
    
    @State var selected = 3;
    
    @State var dollarAmount = 3;
    
    var body: some View {
        VStack{
            
            Text("\(businessName)").bold().font(Font.largeTitle).padding()
            
            Spacer()
            
            Button(
                action: {
                    self.selected = 5
                    
                    self.dollarAmount = 5
            },
                
                label: {
                    
                    Text("$5")
                    
            })
                .padding(self.selected == 5 ? 15 : 0)
                .background(self.selected == 5 ? Color.green : nil)
                .foregroundColor(self.selected == 5 ? Color.white : Color.green)
                .padding(self.selected == 5 ? 0 : 15)
                .font(.largeTitle)
                .border(Color.green, width: 3)
            
            
            Spacer()
            
            HStack{
                Spacer()
                
                Button(
                    action: {
                        
                        self.selected = 4
                        
                        self.dollarAmount = 4
                },
                    
                    label: {
                        
                        Text("$4")
                        
                })
                    .padding(self.selected == 4 ? 15 : 0)
                    .background(self.selected == 4 ? Color.green : nil)
                    .foregroundColor(self.selected == 4 ? Color.white : Color.green)
                    .padding(self.selected == 4 ? 0 : 15)
                    .font(.largeTitle)
                    .border(Color.green, width: 3)
                
                Spacer()
                
                Button(
                    action: {
                        
                        self.selected = 3
                        
                        self.dollarAmount = 3
                },
                    
                    label: {
                        
                        Text("$3")
                        
                })
                    .padding(self.selected == 3 ? 15 : 0)
                    .background(self.selected == 3 ? Color.green : nil)
                    .foregroundColor(self.selected == 3 ? Color.white : Color.green)
                    .padding(self.selected == 3 ? 0 : 15)
                    .font(.largeTitle)
                    .border(Color.green, width: 3)
                
                Spacer()
                
                Button(
                    action: {
                        self.selected = 2
                        
                        self.dollarAmount = 2
                },
                    
                    label: {
                        
                        Text("$2")
                        
                })
                    .padding(self.selected == 2 ? 15 : 0)
                    .background(self.selected == 2 ? Color.green : nil)
                    .foregroundColor(self.selected == 2 ? Color.white : Color.green)
                    .padding(self.selected == 2 ? 0 : 15)
                    .font(.largeTitle)
                    .border(Color.green, width: 3)
                
                Spacer()
            }
            
            Spacer()
            
            Button(
                action: {
                    
                    self.selected = 1
                    
                    self.dollarAmount = 1
            },
                
                label: {
                    
                    Text("$1")
                    
            })
                .padding(self.selected == 1 ? 15 : 0)
                .background(self.selected == 1 ? Color.green : nil)
                .foregroundColor(self.selected == 1 ? Color.white : Color.green)
                .padding(self.selected == 1 ? 0 : 15)
                .font(.largeTitle)
                .border(Color.green, width: 3)
            
            Spacer()
            
            Button(
                action: {
                    self.paymentSheetShown.toggle()
            }
                ,
                label: {
                    SwiftPKPaymentButton().frame(maxWidth: 150, maxHeight: 50).padding()
            })
                .sheet(isPresented: $paymentSheetShown, content: {
                    
                    SwiftPKPaymentAuthorizationViewController(businessId: self.businessId, dollarAmount: self.dollarAmount)
                    
                })
            
        }
    }
}

struct PayView_Previews: PreviewProvider {
    static var previews: some View {
        PayView(businessId: 1, businessName: "Lemming's")
    }
}
