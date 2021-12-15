//
//  BroadcastViewController.swift
//  ERApp
//
//  Created by 丸山昂大 on 2021/12/09.
//

import UIKit
import Firebase



class BroadcastViewController: UIViewController{
    
    @IBOutlet weak var broadcastsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        var areas: [AreaData] = []
        
        let db = Firestore.firestore()
        db.collection("areas").getDocuments() { collection, err in
            
            for document in collection!.documents {
                guard let areaDicList: [[String : Any]] = document.get("areas") as?[[String : Any]] else{
                    continue
                }
                for areaDic in areaDicList {
                    guard let areaId = areaDic["id"] as? String,
                          let areaName = areaDic["name"] as? String else{
                        continue
                    }
                    let area = AreaData(id: areaId, name: areaName)
                    areas.append(area)
                    print("DEBUG_PRINT" + areaName)
                }
            }
            
            if let err = err {
                print("Error getting documents:\(err)")
            } else {
                for document in collection!.documents {
                    guard let hallDicList: [[String : Any]] = document.get("halls") as?[[String : Any]] else {
                        continue
                    }
                    var halls: [HallData] = []
                    
                    for hallDic in hallDicList {
                        guard let hallId = hallDic["id"] as? String,
                              let hallName = hallDic["name"] as? String else{
                            continue
                        }
                        let hall = HallData(id: hallId, name: hallName)
                        halls.append(hall)
                    }
                    
                    for document in collection!.documents{
                        guard let broadcastDicList: [[String : Any]] = document.get("broadcasts") as?[[String : Any]]else{
                            continue
                            
                        }
                        
                        var broadcasts: [BroadcastData] = []
                        for broadcastDic in broadcastDicList {
                            guard let broadcastId = broadcastDic["id"] as? String,
                                  let broadcastName = broadcastDic["name"] as? String,
                                  let broadcastStatus = broadcastDic["status"] as? Int,
                                  let broadcastCode = broadcastDic["code"] as? Int,
                                  let broadcastLevel = broadcastDic["level"] as? Int else{
                                continue
                            }
                            let broadcast = BroadcastData(id: broadcastId, name: broadcastName, code: broadcastCode, status: broadcastStatus, level: broadcastLevel)
                            broadcasts.append(broadcast)
                            
                            
                        }
                    }
                    
                }
            }
            
            
        }
    }
}
