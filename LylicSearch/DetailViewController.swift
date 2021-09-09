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
    
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var birthLabel:UILabel!
    @IBOutlet var homeLabel:UILabel!
    @IBOutlet var heightLabel:UILabel!
    @IBOutlet var massLabel:UILabel!
    @IBOutlet var genderLabel:UILabel!
    @IBOutlet var hairColorLabel:UILabel!
    @IBOutlet var skinColorLabel:UILabel!
    @IBOutlet var eyeColorLabel:UILabel!
    
    
    var url:String=""
    var information:[String:String?] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        
        
        
        AF.request(url,method: .get)
            .responseJSON{response in
                switch response.result{
                case .success(let element):do{
                    
                    
                    let json = JSON(element)
                    
                    self.nameLabel.text=json["name"].string ?? ""
                    self.genderLabel.text=json["gender"].string ?? ""
                    self.birthLabel.text=json["birth_year"].string ?? ""
                    self.heightLabel.text=json["height"].string ?? ""
                    self.massLabel.text=json["mass"].string ?? ""
                    self.hairColorLabel.text=json["hair_color"].string ?? ""
                    self.skinColorLabel.text=json["skin_color"].string ?? ""
                    self.eyeColorLabel.text=json["eye_color"].string ?? ""
                    
                    let planetUrl=json["homeworld"].string ?? ""
                    
                    AF.request(planetUrl ,method: .get)
                        .responseJSON{secondResponse in
                            switch secondResponse.result{
                            case .success(let secondElement):do{
                                
                                let secondJson=JSON(secondElement)
                                
                                self.homeLabel.text=secondJson["name"].string ?? ""
                                
                                
                                
                            }
                            case .failure:do{
                                print("エラー3")
                            }
                            }
                        }
                    
                    
                   
                    
                    
                }
                case .failure:do{
                    print("エラー2")
                }
                }
                
                
                // Do any additional setup after loading the view.
            }
        
    }
    
}
