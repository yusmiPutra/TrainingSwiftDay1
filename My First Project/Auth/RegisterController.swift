//
//  RegisterController.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/26/23.
//

import UIKit
import Alamofire

class RegisterController: UIViewController {
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func registerUser() {
        let parameters: Parameters = [
            "username" : username.text ?? "",
            "fullname" : fullname.text ?? "",
            "email" : email.text ?? "",
            "password" : password.text ?? ""
        ]
        
        AF.request("\(Api.baseUrl)" + "register.php", method: .post, parameters: parameters).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                if let jsonData = value as? [String: Any],
                   let message = jsonData["message"] as? String {
                    print(message)
                    
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
                    
                    self.present(vc, animated: true, completion: nil)
                }
            case .failure(let error):
                print("Error", error)
            }
        }
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        registerUser()
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
