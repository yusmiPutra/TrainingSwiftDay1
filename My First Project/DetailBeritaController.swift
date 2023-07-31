//
//  DetailBeritaController.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/25/23.
//

import UIKit
import SDWebImage
import Alamofire

class DetailBeritaController: UIViewController {
    
    var dataDetail = [String: Any]()

    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var judulDetail: UILabel!
    @IBOutlet weak var isiDetail: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        judulDetail.text = dataDetail["judul"] as? String
        isiDetail.text = dataDetail["isi_berita"] as? String
        
        imageDetail?.sd_setImage(with: URL(string: "\(Api.imageUrl)\(dataDetail["gambar_berita"] ?? "")"))
    
    }
    
    @IBAction func btnBackDetail(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToEdit(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "EditBeritaController") as! EditBeritaController
        
        vc.dataEdit = dataDetail
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func deleteData(_ sender: Any) {
        
        let alert = UIAlertController(title: "Loading", message: "Please wait...", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        
        let parameters: Parameters = [
            "idBerita" : dataDetail["id"] ?? ""
        ]
        
        AF.request("\(Api.baseUrl)" + "delete_berita.php", method: .post, parameters: parameters).responseJSON {
            
            response in
            
            print("Result: \(response.result)")
            switch response.result {
            case .success(let value):
                alert.dismiss(animated: true) {
                    print("TEST")
                    if let jsonData = value as? [String: Any], let message = jsonData["message"] as? String {
                        print("message ", message)
                        
                        if message == "Berhasil Hapus Data"{
                            print("TEST2")
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "PortalBeritaController") as! PortalBeritaController
                            
                            
                            self.present(vc, animated: true, completion: nil)
                        } else {
                            print("message ", message)
                        }
                        
//                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            case .failure(let error):
                print("Error ", error)
            }
        }
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
