//
//  FirstTabController.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/24/23.
//

import UIKit

class FirstTabController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var dataList = [
        ["animal" :"Kucing", "jenis" : "Mamalia"],
        ["animal" :"Ayam", "jenis" : "Reptil"],
        ["animal" :"Ular", "jenis" : "Reptil"],
        ["animal" :"Macan", "jenis" : "Mamalia"],
        ["animal" :"Singa", "jenis" : "Mamalia"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as! AnimalCell
        
        cell.animalName.text = dataList[indexPath.row]["animal"]
        cell.jenisHewan.text = dataList[indexPath.row]["jenis"]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailVc = storyBoard.instantiateViewController(withIdentifier: "DetailController") as! DetailController
        let data = dataList[indexPath.row]
        detailVc.receiverDetail = data
        
        present(detailVc, animated: true, completion: nil)
        
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
