//
//  MatchController.swift
//  ZSoccer
//
//  Created by Matěj Žemlička on 15.03.2022.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class TableMatchController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tvMatches: UITableView!
    
    private var team: [MatchCell] = []
    
    override func viewDidLoad() {
        tvMatches.delegate = self
        tvMatches.dataSource = self
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.string(from: date)
        
        let headers: HTTPHeaders = [
            "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
            "X-RapidAPI-Key": "2758506f2cmsh8c29540ca1126e3p11d5adjsn29d34da85e89"
        ]
        
        let url = "https://api-football-v1.p.rapidapi.com/v3/fixtures?date="
        
        AF.request(url + newDate, headers: headers).responseJSON {
            (response) in let json = try! JSON(data: response.data!)
            
            print(json)
            
            let arr = json["teams"].arrayValue
            
            for teams in arr {
                let a = Match(name1: team["home"]["name"].stringValue,
                             logo1: team["home"]["logo"].UIImage,
                            name2: team["away"]["name"].stringValue,
                            logo2: team["away"]["logo"].UIImage,
                             score1: team["score"]["fulltime"]["home"].intValue,
                             score12: team["score"]["fulltime"]["away"].intValue)
                            
                    
                self.team.append(a)
                
            }
            self.tvMatches.reloadData()
            
        }
        
        tvMatches.reloadData()
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell: MatchCell = tvMatches.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as! MatchCell
        
        cell.nameLbl.text = team[indexPath.item].nameLbl
        cell.nameLbl2.text = team[indexPath.item].nameLbl2
        cell.imgView1.image = team[indexPath.item].imgView1
        cell.imgView2.image = team[indexPath.item].imgView2
        cell.scoreLbl.text = team[indexPath.item].score1
        cell.scoreLbl2.text = team[indexPath.item].score2
        
        return cell
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            
        } else if sender.selectedSegmentIndex == 1 {
            
        } else if sender.selectedSegmentIndex == 2 {
            
        }
    }
}
