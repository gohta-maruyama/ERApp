//
//  StatusViewController.swift
//  ERApp
//
//  Created by 丸山昂大 on 2021/12/10.
//

import UIKit
import Firebase

class StatusViewController: UIViewController {
    
    
    
    @IBAction func normalityButton(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "確認！", message: "状態を「異常なし」に変更しますか？", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            
            (action: UIAlertAction!) -> Void in
            self.statusLabel.text = "異常なし"
            self.statusLabel.layer.backgroundColor = UIColor.white.cgColor
            print("OK")
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
    
    @IBAction func admissionButton(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "確認！", message: "状態を「入局中」に変更しますか？", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            
            (action: UIAlertAction!) -> Void in
            self.statusLabel.text = "入局中"
            self.statusLabel.layer.backgroundColor = UIColor.cyan.cgColor
            print("OK")
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
    
    @IBAction func workingButton(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "確認！", message: "状態を「作業中」に変更しますか？", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            
            (action: UIAlertAction!) -> Void in
            self.statusLabel.text = "作業中"
            self.statusLabel.layer.backgroundColor = UIColor.yellow.cgColor
            print("OK")
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
    
    @IBAction func finishedWorking(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "確認！", message: "状態を「作業完了」に変更しますか？", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            
            (action: UIAlertAction!) -> Void in
            self.statusLabel.text = "作業完了"
            self.statusLabel.layer.backgroundColor = UIColor.green.cgColor
            print("OK")
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
    
    @IBAction func emergencyReady(_ sender: Any) {
    }
    
    @IBOutlet weak var normalityButton: UIButton!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.normalityButton.layer.borderColor = UIColor.black.cgColor
        self.normalityButton.layer.borderWidth = 1.0
    }
    
    @IBOutlet weak var brodcastNameLavel: UILabel!
    var broadcastName: String = ""
    
    @IBOutlet weak var statusLabel: UILabel!
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brodcastNameLavel.text = "\(broadcastName)"
        
        // Do any additional setup after loading the view.
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
