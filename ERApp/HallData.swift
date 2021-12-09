//
//  HallData.swift
//  ERApp
//
//  Created by 丸山昂大 on 2021/12/09.
//
import UIKit

class HallData: NSObject {
    var id: String
    var name: String
    var broadcasts: [BroadcastData] = []
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        
    }
    
}
