//
//  LoginController.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/26/23.
//

import UIKit
import Alamofire

class LoginController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loginUser() {
        let parameters: Parameters = [
            "username" : username.text ?? "",
            "password" : password.text ?? ""
        ]
        
        AF.request("\(Api.baseUrl)" + "login.php", method: .post, parameters: parameters).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                if let jsonData = value as? [String: Any],
                   let message = jsonData["message"] as? String {
                    print(message)
                    if message == "Login Berhasil" {
                        //ini untuk menyimpada data dalam bentuk json String
                        if let data = try? JSONSerialization.data(withJSONObject: jsonData, options: []) {
                            UserDefaults.standard.set(data, forKey: "userData")
                        } else {
                            print("Error converting JSON data to Data Object")
                        }
                        
                        print("test")
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "PortalBeritaController") as! PortalBeritaController
                        
                        self.present(vc, animated: true, completion: nil)
                    }
                   
                }
            case .failure(let error):
                print("Error", error)
            }
        }
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        loginUser()
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
