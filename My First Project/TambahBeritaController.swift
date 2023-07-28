//
//  TambahBeritaController.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/25/23.
//

import UIKit
import Alamofire

class TambahBeritaController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageBerita: UIImageView!
    @IBOutlet weak var judulBerita: UITextField!
    @IBOutlet weak var isiBerita: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        imageBerita.isUserInteractionEnabled = true
        imageBerita.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func tapImage() {
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
            imageBerita.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func insertData() {
        let imageData: Data = imageBerita.image!.pngData()!
        let imageStr : String = imageData.base64EncodedString()
        
        let alert = UIAlertController(title: "Loading", message: "Please wait...", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        
        let parameters: Parameters = [
            "imageStr" : imageStr,
            "judul" : judulBerita.text ?? "",
            "isi" : isiBerita.text ?? ""
        ]
        
        AF.request("\(Api.baseUrl)" + "add_berita.php", method: .post, parameters: parameters).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                alert.dismiss(animated: true) {
                    if let jsonData = value as? [String: Any], let message = jsonData["message"] as? String {
                        print("message ", message)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            case .failure(let error):
                print("Error ", error)
            }
        }
    }
    
    
    @IBAction func btnSimpan(_ sender: Any) {
        insertData()
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
