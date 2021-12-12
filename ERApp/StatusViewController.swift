//
//  StatusViewController.swift
//  ERApp
//
//  Created by 丸山昂大 on 2021/12/10.
//

import UIKit

class StatusViewController: UIViewController {
    
    @IBAction func normalityButton(_ sender: Any) {
        statusLabel.text = "異常なし"
        statusLabel.layer.backgroundColor = UIColor.white.cgColor
    }
    
    @IBAction func admissionButton(_ sender: Any) {
        statusLabel.text = "入局中"
        statusLabel.layer.backgroundColor = UIColor.cyan.cgColor
    }
    
    @IBAction func workingButton(_ sender: Any) {
        statusLabel.text = "作業中"
        statusLabel.layer.backgroundColor = UIColor.yellow.cgColor
    }
    
    @IBAction func finishedWorking(_ sender: Any) {
        statusLabel.text = "作業終了"
        statusLabel.layer.backgroundColor = UIColor.green.cgColor
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
    
    @IBOutlet weak var statusLabel: UILabel!
    
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
