//
//  ViewController.swift
//  LylicSearch
//
//  Created by 生越冴恵 on 2021/09/06.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UITableViewDataSource {
    
    var nameArray=[String?]()
    
    
    
    
    @IBOutlet var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource=self
        
        firstGetData()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text=nameArray[indexPath.row]
        return cell!
    }
    
    func firstGetData(){
        for i in (1...9){
            AF.request("https://swapi.dev/api/people/?page=\(i)",method: .get)
                .responseJSON{response in
                    switch response.result{
                    case .success(let element):do{
                        
                        
                        let json = JSON(element)["results"]
                        
                        json.forEach{(_, json)in
                            //                        print(json["name"].string ?? "エラー")
                            self.nameArray.append(json["name"].string)
                        }
                        
                    }
                    case .failure:do{
                        print("エラー2")
                    }
                    }
                    
                    
                    
                }
            
            
        }
        print(self.nameArray)
        self.tableView.reloadData()
        
    }
}
