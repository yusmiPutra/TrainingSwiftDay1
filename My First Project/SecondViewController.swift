//
//  SecondViewController.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/24/23.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var lblDetail: UILabel!
    var receiver: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDetail.text = receiver
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
