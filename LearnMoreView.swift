//
//  LearnMoreView.swift
//  FirebaseLoginnn
//
//  Created by user180116 on 11/20/20.
//  Copyright © 2020 Bala. All rights reserved.
//

import SwiftUI

struct LearnMoreView: View {
    var body: some View {
        ScrollView {
            VStack {
                Image("flower")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding(.bottom)
                HStack {
                    VStack(alignment:.leading, spacing: 8)
                        {
                        Text("Avoid Flowers")
                            .font(.title)
                            .fontWeight(.black)
                        Text("Flowers act as noise for the app, do your best to avoid them in the shot")
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                    }.padding()
                }
                Image("fog")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding(.bottom)
                HStack {
                    VStack(alignment:.leading, spacing: 8)
                        {
                        Text("Good Lighting")
                            .font(.title)
                            .fontWeight(.black)
                        Text("Avoid using pictures with bad lighting.")
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                    }.padding()
                }
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding(.bottom)
                HStack {
                    VStack(alignment:.leading, spacing: 8)
                        {
                        Text("Use a Clear, Plain Background")
                            .font(.title)
                            .fontWeight(.black)
                        Text("Ensure that your background is of a clear color and plain.")
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                    }.padding()
                }
                Image("leaves")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding(.bottom)
                HStack {
                    VStack(alignment:.leading, spacing: 8)
                        {
                        Text("Focus on the Leaves")
                            .font(.title)
                            .fontWeight(.black)
                        Text("Focus the image on the leaves so the app can calculate the plant's status with higher accuracy.")
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                    }.padding()
                }            }
        }
    }
}

struct LearnMoreView_Previews: PreviewProvider {
    static var previews: some View {
        LearnMoreView()
    }
}
