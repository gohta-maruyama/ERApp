//
//  HallViewController.swift
//  ERApp
//
//  Created by 丸山昂大 on 2021/12/15.
//

import UIKit
import Firebase



class HallViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var areasArray: [AreaData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return areasArray.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return areasArray[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return areasArray[section].halls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath)
        
        let area = areasArray[indexPath.section]
        let hall = area.halls[indexPath.row]

        cell.textLabel?.text = hall.name
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let broadcastControllerView: BroadcastViewController = segue.destination as! BroadcastViewController
        
        if segue.identifier == "cellSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let area = areasArray[indexPath!.section]
            broadcastControllerView.area = areasArray[indexPath!.section]
            broadcastControllerView.hall = area.halls[indexPath!.row]
        }
        
    }
    

}
