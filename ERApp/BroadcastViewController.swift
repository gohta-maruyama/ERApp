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
    
    var broadArray: [BroadcastData] = []
    var area: AreaData?;
    var hall: HallData?;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if Auth.auth().currentUser != nil {
            let broadRef = Firestore.firestore().collection("areas").document(area!.id).collection("halls").document(hall!.id).collection("broadcasts").order(by: "level")
            broadRef.getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
                    return
                }
                self.broadArray = querySnapshot!.documents.map { document in
                    let broadcast = BroadcastData(document: document)
                    print("DEBUG_PRINT: document取得 \(broadcast.name)")

                    return broadcast

                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return broadArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let broadcast = broadArray[indexPath.row]
        
        cell.textLabel?.text = broadcast.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showStatusSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStatusSegue" {
            if let indexPath = tableView.indexPathForSelectedRow{
                
               guard let destination = segue.destination as? StatusViewController else{
                
               fatalError("Failed to prepare StatusViewController")
            }
                destination.broadcastName = broadArray[indexPath.row].name
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        
    }
    
    
}
