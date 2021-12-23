//
//  StatusViewController.swift
//  ERApp
//
//  Created by 丸山昂大 on 2021/12/10.
//

import UIKit
import Firebase
import SVProgressHUD

class StatusViewController: UIViewController {
    
    var area: AreaData!
    var hall: HallData!
    var broadcast: BroadcastData!
    var emergency: EmergencyData!
    var emergencyArray: [EmergencyData] = []
    var statusNumber: Int = 0
    var alertMessage: String = ""
    
    @IBAction func normalityButton(_ sender: Any) {
        showStatusChangeAlert(message: "状態を「異常なし」に変更しますか？", status: 0)
        
    }
    
    @IBAction func admissionButton(_ sender: Any) {
        showStatusChangeAlert(message: "状態を「入局中」に変更しますか？", status: 1)
        
    }
    
    @IBAction func workingButton(_ sender: Any) {
        showStatusChangeAlert(message: "状態を「作業中」に変更しますか？", status: 2)
        
    }
    
    @IBAction func finishedWorking(_ sender: Any) {
        showStatusChangeAlert(message: "状態を「作業完了」に変更しますか？", status: 3)
        
    }
    
    @IBAction func emergencyReady(_ sender: Any) {
        showStatusChangeAlert(message: "状態を「火起完了」に変更しますか？", status: 4)
        emergencyReady.isHidden = true
        emergencyReady.isEnabled = false
        
    }
    @IBOutlet weak var emergencyReady: UIButton!
    
    
    
    @IBOutlet weak var normalityButton: UIButton!
    @IBOutlet weak var admissionButton: UIButton!
    @IBOutlet weak var workingButton: UIButton!
    @IBOutlet weak var finishedWorking: UIButton!
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.normalityButton.layer.borderColor = UIColor.black.cgColor
        self.normalityButton.layer.borderWidth = 1.0
    }
    
    
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var broadcastNameLabel: UILabel!
    @IBOutlet weak var warningMark: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        broadcastNameLabel.text = broadcast?.name
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .repeat, animations: {self.warningMark.alpha = 0.0} ) {
            (_) in
            self.warningMark.alpha = 1.0
        }
        
        // Do any additional setup after loading the view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Firestore.firestore().collection("emergencies").document(hall.id).addSnapshotListener { documentSnapshot, error in
            guard let documentSnapshot = documentSnapshot
            else {
                print("Error fetching document: \(error!)")
                return
            }
            let source = documentSnapshot.metadata.hasPendingWrites ? "Local" : "Server"
            print("\(source) data : \(documentSnapshot.data()!)")
            
            if let document = documentSnapshot.data() , let status = document["emergencyStatus"] as? Int {
                if status == 1 {
                    self.emergencyAlert()
                } else if status == 2 {
                    self.finishedEmergencyAlert()
                }
            }
            
        }
        
    }
    
    func updateStatus(status: Int) {
        let ref = Firestore.firestore().collection("areas").document(area!.id).collection("halls").document(hall!.id).collection("broadcasts").document(broadcast!.id)
        
        ref.updateData([
            "status": status
        ])
        
        self.broadcast?.status = status
        
        setStatusLabel()
    }
    
    func updateEmergencyStatus() {
        let ref = Firestore.firestore().collection("emergencies").document(hall.id)
        ref.updateData([
            "emergencyStatus": 0
        ])
        self.emergency?.emergencyStatus = 0
    }
    

    func setStatusLabel() {
        if broadcast.status == 0 {
            self.statusLabel.text = "異常なし"
            self.statusLabel.layer.backgroundColor = UIColor.white.cgColor
        } else if broadcast.status == 1 {
            self.statusLabel.text = "入局中"
            self.statusLabel.layer.backgroundColor = UIColor.cyan.cgColor
        } else if broadcast.status == 2 {
            self.statusLabel.text = "作業中"
            self.statusLabel.layer.backgroundColor = UIColor.yellow.cgColor
        } else if broadcast.status == 3 {
            self.statusLabel.text = "作業完了"
            self.statusLabel.layer.backgroundColor = UIColor.green.cgColor
        } else if broadcast.status == 4 {
            self.statusLabel.text = "火起完了"
            self.statusLabel.layer.backgroundColor = UIColor.orange.cgColor
        } else if broadcast.status == 5 {
            self.statusLabel.text = "火起こし中"
            self.statusLabel.layer.backgroundColor = UIColor.orange.cgColor
            warningMark.isHidden = false
        }
        
    }
    
    func showStatusChangeAlert(message: String, status: Int) {
        let alert: UIAlertController = UIAlertController(title: "確認！", message: "\(message)", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            
            (action: UIAlertAction!) -> Void in
            self.updateStatus(status: status)
            self.updateEmergencyStatus()
            print("OK2")
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
 
    
    func emergencyAlert() {
        let emergencyAlert: UIAlertController = UIAlertController(title: "緊急", message: "火起こしを開始してください", preferredStyle: UIAlertController.Style.alert)
        let defaulAction: UIAlertAction = UIAlertAction(title: "確認", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) -> Void in
            self.emergencyReady.isHidden = false
            self.emergencyReady.isEnabled = true
            self.normalityButton.isHidden = true
            self.admissionButton.isHidden = true
            self.workingButton.isHidden = true
            self.finishedWorking.isHidden = true
            self.broadcast.status = 5
            self.setStatusLabel()
            print("emergencyAlert:OK")
        })
        emergencyAlert.addAction(defaulAction)
        present(emergencyAlert, animated: true, completion: nil)
    }
    
    func finishedEmergencyAlert() {
        let finishedemergencyAlert: UIAlertController = UIAlertController(title: "火起こし終了", message: "作業を再開してください", preferredStyle: UIAlertController.Style.alert)
        let defaulAction: UIAlertAction = UIAlertAction(title: "確認", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) -> Void in
            self.warningMark.isHidden = true
            self.normalityButton.isHidden = false
            self.admissionButton.isHidden = false
            self.workingButton.isHidden = false
            self.finishedWorking.isHidden = false
            print("finishedEmergencyAlert:OK")
        })
        finishedemergencyAlert.addAction(defaulAction)
        present(finishedemergencyAlert, animated: true, completion: nil)
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
