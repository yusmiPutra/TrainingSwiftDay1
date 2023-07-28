//
//  SplashScreenController.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/26/23.
//

import UIKit

class SplashScreenController: UIViewController {
    
    
    func getSession() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            if let data = UserDefaults.standard.data(forKey: "userData") {
                if let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("userdata \(jsonData)")
                    
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "PortalBeritaController") as! PortalBeritaController
                    
                    self.present(vc, animated: true, completion: nil)
                } else {
                    print("Error converting Data to Json")
                }
            } else {
                print("Json data not found in UserDefault")
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
                
                self.present(vc, animated: true, completion: nil)
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getSession()

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
