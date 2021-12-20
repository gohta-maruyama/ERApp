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
    var emergencyStatus: Int?
    var halls: [HallData] = []
    
    init(id: String, status: Int) {
        self.id = id
        self.emergencyStatus = status
        
    }
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        
        let emergencyDic = document.data()
        
        self.emergencyStatus = emergencyDic["status"] as! Int?
        
        }
    
}
