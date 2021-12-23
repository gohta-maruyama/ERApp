//
//  EmergencyData.swift
//  ERApp
//
//  Created by 丸山昂大 on 2021/12/20.
//

import UIKit
import Firebase

class EmergencyData: NSObject {
    var id: String
    var name: String
    var emergencyStatus: Int
    var halls: [HallData] = []
    
    init(id: String, name: String, emergencyStatus: Int) {
        self.id = id
        self.name = name
        self.emergencyStatus = emergencyStatus
        
    }
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        
        let emergencyDic = document.data()
        
        self.name = emergencyDic["name"] as! String
        self.emergencyStatus = emergencyDic["emergencyStatus"] as! Int
        
        }
    
}
