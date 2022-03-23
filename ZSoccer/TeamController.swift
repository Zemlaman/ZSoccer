//
//  TeamController.swift
//  ZSoccer
//
//  Created by Matěj Žemlička on 22.03.2022.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class TeamController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tvNews: UITableView!
    private var teams: [Team] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvNews.delegate = self
        //tvNews.dataSource = self
    /*
    AF.request("https://newsapi.org/v2/everything?q=apple&sortBy=popularity&apiKey=1f822e3a8be14d43a008bcb21d7d00c5").responseJSON {
            (response) in let json = try! JSON(data: response.data!)
            
        print(json)
        
            let arr = json["articles"].arrayValue
            
            for article in arr {
                let a = Article(title: article["title"].stringValue, description: article["description"].stringValue, link: article["url"].stringValue)
                self.news.append(a)
                
            }
            self.tvNews.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Abc", for: indexPath) as! Abc
        
        cell.title.text = news[indexPath.item].title
        cell.descriptionLabel.text = news[indexPath.item].description
        cell.link.text = news[indexPath.item].link

        return cell;
     */
    }

}

