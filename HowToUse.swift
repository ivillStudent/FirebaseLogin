//
//  HowToUse.swift
//  FirebaseLoginnn
//
//  Created by user180867 on 11/5/20.
//  Copyright © 2020 Bala. All rights reserved.
//
import SwiftUI
import Foundation
import WebKit
import Firebase


struct HowToUse: View {
    
    var body: some View {
        
            ScrollView {
                VStack{
                    Image("takingPic")
                        .resizable()
                        .aspectRatio(contentMode:.fit)
                        .cornerRadius(10)
                        .padding(.bottom)
                    HStack{
                        VStack(alignment:.leading, spacing:8){
                            Text("How to Use")
                                .font(.title)
                                .fontWeight(.black)
                            Text("Detailed information of how to take pictures to maximize your result.")
                                .foregroundColor(.secondary)
                                .lineLimit(3)
                            NavigationLink(
                                destination: LearnMoreView()){
                                Text ("Learn more")
                                    .bold()
                                    .foregroundColor(.green)
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.green)
                                
                            }
                            
                        }.padding()
                        
                    }
                }
            }
        }
    }


struct HowToUse_Previews: PreviewProvider {
    static var previews: some View {
        HowToUse()
    }
}
