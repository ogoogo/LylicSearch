//
//  DetailViewController.swift
//  LylicSearch
//
//  Created by 生越冴恵 on 2021/09/09.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {
    
    var url:String=""

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        AF.request(url,method: .get)
            .responseJSON{response in
                switch response.result{
                case .success(let element):do{
                    
                    
                    let json = JSON(element)
                    print(json["name"].string ?? "エラー")
        
//                                                    print(json[
                        
                    
                }
                case .failure:do{
                    print("エラー2")
                }
                }
                

        // Do any additional setup after loading the view.
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
}
