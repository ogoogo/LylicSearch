//
//  ViewController.swift
//  LylicSearch
//
//  Created by 生越冴恵 on 2021/09/06.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UITableViewDataSource,UISearchBarDelegate,UITableViewDelegate {
    
    var characterArrays:[[String:String?]]=[]
    var index=0
    var nextUrl:String!
    
    
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var searchBar:UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource=self
        searchBar.delegate=self
        tableView.delegate=self
        
        getData(url:"https://swapi.dev/api/people" )
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characterArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text=characterArrays[indexPath.row]["name"]!
        return cell!
    }
    
    func getData(url:String){
        
            AF.request(url,method: .get)
                .responseJSON{response in
                    switch response.result{
                    case .success(let element):do{
                        
                        
                        let json = JSON(element)["results"]
                        
                        json.forEach{(_, json)in
//                                                    print(json["url"].string ?? "エラー")
                            let characterArray:[String:String?]=[
                                "name":json["name"].string,
                                "url":json["url"].string ]
                            
                            self.characterArrays.append(characterArray)
                        }
//                        print(self.characterArrays)
                        self.tableView.reloadData()
                        
                        
                        let nextCheck:String=JSON(element)["next"].string ?? ""
                        
                        if nextCheck != ""{
                            self.getData(url: nextCheck)
                        }
                        
                    }
                    case .failure:do{
                        print("エラー2")
                    }
                    }
                    
                    
                    
                }
            
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let word = searchBar.text{
            characterArrays=[]
            getData(url: "https://swapi.dev/api/people"+"/?search=\(word)")
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index=indexPath.row
        nextUrl=characterArrays[index]["url"]!!
        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController=segue.destination as? DetailViewController
        detailViewController?.url=self.nextUrl
    }
}


