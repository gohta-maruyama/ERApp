//
//  BroadcastViewController.swift
//  ERApp
//
//  Created by 丸山昂大 on 2021/12/09.
//

import UIKit
import Firebase



class BroadcastViewController: UIViewController {
    @IBOutlet weak var broadcastsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var areas: [AreaData] = []
        var halls: [HallData] = []
        
        let db = Firestore.firestore()
        db.collection("areas").getDocuments() { collection, err in
            
            if let err = err {
                print("Error getting documents:\(err)")
            } else {
                for document in collection!.documents {
                    guard let broadcastDicList: [[String : Any]] = document.get("broadcasts") as?[[String : Any]] else {
                        continue
                    }
                    var broadcasts: [BroadcastData] = []
                    
                    for broadcastDic in broadcastDicList {
                        guard let broadcastId = broadcastDic["id"] as? String,
                              let broadcastName = broadcastDic["name"] as? String,
                              let broadcastCode = broadcastDic["code"] as? Int,
                              let broadcastStatus = broadcastDic["status"] as? Int,
                              let broadcastLevel = broadcastDic["level"] as? Int else{
                            continue
                        }
                        let broadcast = BroadcastData(id: broadcastId, name: broadcastName, code: broadcastCode, status: broadcastStatus, level: broadcastLevel)
                        
                        broadcasts.append(broadcast)
                    }
                    guard let hallId = document.get("id") as? String,
                          let hallName = document.get("name") as? String else {
                        continue
                    }
                    
                    let hall = HallData(id: hallId, name: hallName)
                    halls.append(hall)
                    
                    guard let areaId = document.get("id") as? String,
                          let areaName = document.get("name") as? String else {
                        continue
                    }
                    
                    let area = AreaData(id: areaId, name: areaName)
                    areas.append(area)
                
                }
            }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
}
