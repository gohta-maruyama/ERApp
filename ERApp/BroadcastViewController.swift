//
//  BroadcastViewController.swift
//  ERApp
//
//  Created by 丸山昂大 on 2021/12/09.
//


import UIKit
import Firebase

class BroadcastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var areasArray: [AreaData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        searchBar.delegate = self
//        searchBar.enablesReturnKeyAutomatically = false
        
        
        
        if Auth.auth().currentUser != nil {
            // listenerを登録して投稿データの更新を監視する
            let areasRef = Firestore.firestore().collection("areas").order(by: "name")
            areasRef.getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
                    return
                }
                self.areasArray = querySnapshot!.documents.map { document in

                    let area = AreaData(document: document)
                    print("DEBUG_PRINT: document取得 \(area.name)")
                    // ここでさらにhallsを取得する。
                    let hallsRef = Firestore.firestore().collection("areas").document(area.id).collection("halls").order(by: "name")
                    hallsRef.getDocuments() { (hallQuerySnapshot, hallError) in
                        if let hallError = hallError {
                            print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(hallError)")
                            return
                        }
                        area.halls = hallQuerySnapshot!.documents.map { document in

                            let hall = HallData(document: document)
                            print("DEBUG_PRINT: document取得 \(hall.name)")
                            
                            let broadcastsRef = Firestore.firestore().collection("areas").document(area.id).collection("halls").document(hall.id).collection("broadcasts").order(by: "name")
                            broadcastsRef.getDocuments() {(broadcastQuerySnapshot, broadcastError) in
                                if let broadcastError = broadcastError {
                                    print("DEBUG_PRINT: snapshotの取得が失敗しました。\(broadcastError)")
                                    return
                                }
                                hall.broadcasts = broadcastQuerySnapshot!.documents.map { document in
                                    
                                    let broadcast = BroadcastData(document: document)
                                    print("DEBUG_PRINT: document取得 \(broadcast.name)")
                                    
                                    return broadcast
                                }
                                self.tableView.reloadData()
                            }
                            
                            return hall
                        }
                        self.tableView.reloadData()
                    }
                    return area
    
                }
                // TableViewの表示を更新する
                self.tableView.reloadData()

            }
                // Do any additional setup after loading the view.
                
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areasArray[section].halls[section].broadcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let area = areasArray[indexPath.section]
        let hall = area.halls[indexPath.section]
        let broadcast = hall.broadcasts[indexPath.row]
        
        cell.textLabel?.text = hall.broadcasts
        
        return cell
    }
}
