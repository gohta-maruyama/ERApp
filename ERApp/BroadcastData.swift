//
//  BroadcastData.swift
//  ERApp
//
//  Created by 丸山昂大 on 2021/12/09.
//
import UIKit

class BroadcastData: NSObject {
    var id: String
    var name: String
    var code: Int
    var status: Int
    var level: Int

    
    init(id: String, name: String, code: Int, status: Int, level: Int) {
        self.id = id
        self.name = name
        self.code = code
        self.status = status
        self.level = level
    }
    
}


