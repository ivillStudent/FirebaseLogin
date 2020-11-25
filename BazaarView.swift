//
//  BazaarView.swift
//  FirebaseLoginnn
//
//  Created by user180867 on 10/30/20.
//  Copyright © 2020 Bala. All rights reserved.
//
import SwiftUI
import Foundation


struct BazaarView: View {
    var body: some View{
        NavigationView{
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 8){
                        Text("Bazaar Coming Soon!!!")
                            .font(.title)
                            .foregroundColor(.green)
                            Image("store")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                                .padding(.bottom)
                                
                        
                    }
                        
                }
            }
        
        }.navigationBarTitle(Text("Bazaar"))
    }
}



struct BazaarView_Previews: PreviewProvider {
    static var previews: some View {
        BazaarView()
    }
}
