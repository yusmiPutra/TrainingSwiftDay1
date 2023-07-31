//
//  PortalBeritaController.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/25/23.
//

import UIKit

class PortalBeritaController: UIViewController {
    
    @IBOutlet weak var tabelViewBerita: UITableView!
    var listBerita = [[String: Any]]()
    @IBOutlet weak var searchData: UISearchBar!
    var filterBerita = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListBerita()
        
        // Do any additional setup after loading the view.
    }
    
    func getListBerita() {
        let urlString = Api.baseUrl + "getBerita.php"
        guard let url = URL(string: "\(urlString)")
        else { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                
                guard let jsonArray = jsonResponse as? [String: Any] else {
                    return
                }
                
                guard let berita = jsonArray["data"] as? [[String: Any]] else {
                    return
                }
                
                self.listBerita = berita
                self.filterBerita = self.listBerita
                
                print("list berita \(self.filterBerita)")
                
                DispatchQueue.main.async {
                    self.tabelViewBerita.reloadData()
                }
                
            } catch let error {
                print("Error", error)
            }
        }
        task.resume()
    }
    
    func celearUserDefault() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
    }
    
    
    @IBAction func btnLogout(_ sender: Any) {
        let alert = UIAlertController(title: "Yakin Mau keluar", message: "Please wait...", preferredStyle: .alert)
        
        let actionOk = UIAlertAction(title: "OK", style: .default) { _ in
            self.celearUserDefault()
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
            self.present(vc, animated: true, completion: nil)
        }
        
        let actionNo = UIAlertAction(title: "No", style: .cancel) { _ in
            //            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(actionOk)
        alert.addAction(actionNo)
        present(alert, animated: true, completion: nil)
    }
}


extension PortalBeritaController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchData.text != "" {
            return filterBerita.count
        } else {
            return listBerita.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tabelViewBerita.dequeueReusableCell(withIdentifier: "cellBerita", for: indexPath) as! BeritaCell
        
        if searchData.text != "" {
            let item = filterBerita[indexPath.row]
            
            cell.judulBerita.text = item["judul"] as? String
            
            DispatchQueue.global().async {
                let strImageBerita = "\(Api.imageUrl)\(item["gambar_berita"] ?? "")"
                
                if let imageUrl = URL(string: strImageBerita) {
                    if let dataImg = try? Data(contentsOf: imageUrl) {
                        guard let image = UIImage(data: dataImg) else {
                            return
                        }
                        DispatchQueue.main.async {
                            cell.imageBerita.image = image
                        }
                    }
                }
            }
        } else {
            let item = listBerita[indexPath.row]
            
            cell.judulBerita.text = item["judul"] as? String
            
            DispatchQueue.global().async {
                let strImageBerita = "\(Api.imageUrl)\(item["gambar_berita"] ?? "")"
                
                if let imageUrl = URL(string: strImageBerita) {
                    if let dataImg = try? Data(contentsOf: imageUrl) {
                        guard let image = UIImage(data: dataImg) else {
                            return
                        }
                        DispatchQueue.main.async {
                            cell.imageBerita.image = image
                        }
                    }
                }
            }
        }
    
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if searchData.text != "" {
            let detaiVc = storyBoard.instantiateViewController(withIdentifier: "DetailBerita") as! DetailBeritaController
            
            let data = filterBerita[indexPath.row]
            detaiVc.dataDetail = data
            self.present(detaiVc, animated: true, completion: nil)
        } else {
            let detaiVc = storyBoard.instantiateViewController(withIdentifier: "DetailBerita") as! DetailBeritaController
            
            let data = listBerita[indexPath.row]
            detaiVc.dataDetail = data
            self.present(detaiVc, animated: true, completion: nil)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var searchDebounceTimer: Timer?
        searchDebounceTimer?.invalidate()
        
        // Use a guard statement to handle the empty case.
        guard !searchText.isEmpty else {
            self.filterBerita = listBerita
            tabelViewBerita.reloadData()
            return
        }
        
        // Start a new timer to debounce the filtering operation.
        searchDebounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.filterBerita = self?.listBerita.filter { dataItem in
                if let item = dataItem["judul"] as? String {
                    return item.lowercased().contains(searchText.lowercased())
                }
                return false
            } ?? []
            DispatchQueue.main.async {
                self?.tabelViewBerita.reloadData()
            }
        }
    }
}
