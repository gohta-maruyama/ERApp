//
//  SettingViewController.swift
//  ERApp
//
//  Created by 丸山昂大 on 2021/12/10.
//

import UIKit
import Firebase
import SVProgressHUD

class SettingViewController: UIViewController {
    @IBAction func handleLogoutButton(_ sender: Any) {
        
        let alert: UIAlertController = UIAlertController(title: "確認", message: "ログアウトしますか？", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            
            (action: UIAlertAction!) -> Void in
            try! Auth.auth().signOut()
            
            // ログイン画面を表示する
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil)
            
            // ログイン画面から戻ってきた時のためにホーム画面（index = 0）を選択している状態にしておく
            self.tabBarController?.selectedIndex = 0
            
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
        // ログアウトする
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
