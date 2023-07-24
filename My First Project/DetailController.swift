//
//  DetailController.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/24/23.
//

import UIKit

class DetailController: UIViewController {

    var receiverDetail: [String: Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Detail \(receiverDetail["animal"] ?? "")")

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
