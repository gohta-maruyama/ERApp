//
//  AreaData.swift
//  ERApp
//
//  Created by 丸山昂大 on 2021/12/09.
//
import UIKit

class AreaData: NSObject {
    var id: String
    var name: String
    var halls: [HallData] = []
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        
    }
}
