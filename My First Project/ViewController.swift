//
//  ViewController.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/24/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblFirstname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        txtFirstname.text = "Yusmi Putra"
        // Do any additional setup after loading the view.
    }

    @IBAction func btnRegister(_ sender: Any) {
        lblFirstname.text = txtFirstname.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? SecondViewController
        
        let firstName = txtFirstname.text
        let lastName = txtLastname.text
        
        vc?.receiver = "Selamat datang, \(firstName ?? "") \(lastName ?? "")"
    }
    
}

