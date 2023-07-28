//
//  EditBeritaController.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/26/23.
//

import UIKit
import SDWebImage
import Alamofire

class EditBeritaController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageEdit: UIImageView!
    
    @IBOutlet weak var isiEdit: UITextView!
    @IBOutlet weak var judulEdit: UITextField!
    var dataEdit = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        judulEdit.text = dataEdit["judul"] as? String
        isiEdit.text = dataEdit["isi_berita"] as? String
        imageEdit?.sd_setImage(with: URL(string: "\(Api.imageUrl)\(dataEdit["gambar_berita"] ?? "")"))
        
        let taGesture = UITapGestureRecognizer(target: self, action: #selector(imageTap))
        imageEdit.isUserInteractionEnabled = true
        imageEdit.addGestureRecognizer(taGesture)
        
        
        print("data edit \(dataEdit["id"] ?? "")")
        // Do any additional setup after loading the view.
    }
    
    func updateData() {
        let imageData: Data = imageEdit.image!.pngData()!
        let imageStr : String = imageData.base64EncodedString()
        
        let alert = UIAlertController(title: "Loading", message: "Please wait...", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        
        let parameters: Parameters = [
            "imageStr" : imageStr,
            "judul" : judulEdit.text ?? "",
            "isi" : isiEdit.text ?? "",
            "idBerita" : dataEdit["id"] ?? ""
        ]
        
    
        
        
        
        AF.request("\(Api.baseUrl)" + "update_berita.php", method: .post, parameters: parameters).responseJSON {
            
            response in
            
            print("Result: \(response.result)")
            switch response.result {
            case .success(let value):
                alert.dismiss(animated: true) {
                    print("TEST")
                    if let jsonData = value as? [String: Any], let message = jsonData["message"] as? String {
                        print("message ", message)
                        
                        if message == "Berhasil Update Data"{
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
    
    @objc func imageTap() {
        showImagePicker()
    }
    
    
    
    func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageEdit.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        updateData()
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
