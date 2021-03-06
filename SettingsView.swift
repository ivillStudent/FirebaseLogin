//
//  Settings.swift
//  FirebaseLoginnn
//
//  Created by user180867 on 10/30/20.
//  Copyright © 2020 Bala. All rights reserved.
//
/**
import Foundation
import SwiftUI
import Firebase
import UIKit

var globalAcceptPercentage = 0.7
var globalRedColor = 0.0
var globalGreenColor = 0.0
var globalBlueColor = 0.0
var globalFertilizer = true
var globalCropping = true

var globalPlantName1 = ""
var globalPlantName2 = ""
var globalPlantName3 = ""
var globalPlantName4 = ""

var globalRedColor1 = 0.0
var globalGreenColor1 = 0.0
var globalBlueColor1 = 0.0
var globalRedColor2 = 0.0
var globalGreenColor2 = 0.0
var globalBlueColor2 = 0.0
var globalRedColor3 = 0.0
var globalGreenColor3 = 0.0
var globalBlueColor3 = 0.0
var globalRedColor4 = 0.0
var globalGreenColor4 = 0.0
var globalBlueColor4 = 0.0

var globalAcceptPercentageLow = 0.0
var globalAcceptPercentageMedium = 0.0
var globalAcceptPercentageHigh = 0.0


struct SettingsView: View {
    
    @ObservedObject var viewRouter = ViewRouter()
    @State var showPopUp = false
    @State var viewState = CGSize.zero
    @State var MainviewState =  CGSize.zero
    @State var accuracylevel = 1
    @State var typePlant = 0
    @State var toggleRecommendations = UserDefaults.standard.bool(forKey: "recom")
    @State var toggleCropping = UserDefaults.standard.bool(forKey: "crop")
    
    var body: some View {
        //Text("Settings")
        //  .foregroundColor(greenColor)
        //  .fontWeight(.semibold).font(.largeTitle)
        //  .frame(maxWidth: 400, maxHeight: 150, alignment: Alignment.topLeading)
        VStack {
            Text("Plant type").foregroundColor(greyColor)
        Picker("", selection: self.$typePlant) {
            Text(globalPlantName1).tag(0)
            Text(globalPlantName2).tag(1)
            Text(globalPlantName3).tag(2)
            Text(globalPlantName4).tag(3)
        }.pickerStyle(SegmentedPickerStyle())
            .frame(maxWidth: 400, maxHeight: 50, alignment: Alignment.topLeading)
            .onReceive([self.typePlant].publisher.first()) { (value) in
                if (value == 0) {
                    globalRedColor = globalRedColor1
                    globalGreenColor = globalGreenColor1
                    globalBlueColor = globalBlueColor1
                } else if (value == 1) {
                    globalRedColor = globalRedColor2
                    globalGreenColor = globalGreenColor2
                    globalBlueColor = globalBlueColor2
                } else if (value == 2) {
                    globalRedColor = globalRedColor3
                    globalGreenColor = globalGreenColor3
                    globalBlueColor = globalBlueColor3
                } else if (value == 3) {
                    globalRedColor = globalRedColor4
                    globalGreenColor = globalGreenColor4
                    globalBlueColor = globalBlueColor4
                }
        }
        Text("Image accuracy").foregroundColor(greyColor)
        Picker(selection: self.$accuracylevel, label: Text("")) {
            Text("Low").tag(0)
            Text("Medium").tag(1)
            Text("High").tag(2)
        }.pickerStyle(SegmentedPickerStyle())
            .frame(maxWidth: 400, maxHeight:50, alignment: Alignment.topLeading)
            .onReceive([self.accuracylevel].publisher.first()) { (value) in
                if (value == 0) {
                    globalAcceptPercentage = globalAcceptPercentageLow
                } else if (value == 1) {
                    globalAcceptPercentage = globalAcceptPercentageMedium
                } else if (value == 2) {
                    globalAcceptPercentage = globalAcceptPercentageHigh
                }
        }
        HStack {
            Text("Fertilizer recommendations          ")
                .foregroundColor(self.toggleRecommendations ? greenColor : greyColor)
            Toggle("Sound", isOn: self.$toggleRecommendations)
                .labelsHidden()
        }
        .onReceive([self.toggleRecommendations].publisher.first()) { (value) in
            if (self.toggleRecommendations) {
                globalFertilizer = true
                UserDefaults.standard.set(self.toggleRecommendations, forKey: "recom")
            } else {
                globalFertilizer = false
                UserDefaults.standard.set(self.toggleRecommendations, forKey: "recom")
            }
        }.frame(maxWidth: 400, maxHeight: 50, alignment: Alignment.center)
        HStack {
            Text("Image cropping                              ")
                .foregroundColor(self.toggleCropping ? greenColor : greyColor)
            Toggle("Sound", isOn: self.$toggleCropping)
                .labelsHidden()
        }
        .onReceive([self.toggleCropping].publisher.first()) { (value) in
            if (self.toggleCropping) {
                globalCropping = true
                UserDefaults.standard.set(self.toggleCropping, forKey: "crop")
            } else {
                globalCropping = false
                UserDefaults.standard.set(self.toggleCropping, forKey: "crop")
            }
        }.frame(maxWidth: 400, maxHeight: 30, alignment: Alignment.center)
        Button(action: {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            self.viewRouter.currentView = "logout"
        }, label: {
            Text("Sign Out")
                .frame(minWidth: 220, maxWidth: 220, minHeight: 60, maxHeight: 60, alignment: .center)
                .foregroundColor(.white)
                .background(greenColor)
                .cornerRadius(15.0)
                .font(.headline)
        
            
        })
    
        
    }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
*/
