//
//  ResourcesInfo.swift
//  FirebaseLoginnn
//
//  Created by user180867 on 10/25/20.
//  Copyright © 2020 Bala. All rights reserved.
//


import Foundation


struct ResourcesInfo: Hashable {
    
    let image: String
    let title: String
    let des:String
    
}


let resourcesInfo = [
    ResourcesInfo(image: "takinPic", title: "How to use",des: "Detailed information of how to take pictures to maximize your result."), ResourcesInfo(image: "WateringPlants", title: "Tips for Healthy Plants", des: "Follow these simple tips to grow healthy plants"), ResourcesInfo(image: "Terms", title: "Terms and Conditions", des: "Here is our terms and conditions for this app.")
]
