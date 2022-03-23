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

class TeamController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tvTeams: UITableView!
    
    private var team: [Team] = []
    
    override func viewDidLoad() {
        tvTeams.delegate = self
        tvTeams.dataSource = self
    
        
        let headers: HTTPHeaders = [
            "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
            "X-RapidAPI-Key": "2758506f2cmsh8c29540ca1126e3p11d5adjsn29d34da85e89"
        ]
        
        let url = "https://api-football-v1.p.rapidapi.com/v3/teams?league=39&season=2021"
   
    AF.request(url, headers: headers).responseJSON {
            (response) in let json = try! JSON(data: response.data!)
            
        print(json)
        
            let arr = json["response"].arrayValue
            
            for team in arr {
                let a = Team(name: team["team"]["name"].stringValue,
                             country: team["team"]["country"].stringValue,
                            logoTeam: team["team"]["logo"].stringValue)
                
                self.team.append(a)
                print(a)
                
            }
            self.tvTeams.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TeamCell = tvTeams.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! TeamCell
        
        cell.nameLbl.text = team[indexPath.item].name
        cell.countryLbl.text = team[indexPath.item].country
        getData(from: URL(string: team[indexPath.item].logoTeam)!) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                cell.logo.image = UIImage(data: data)
            }
        }
        

        return cell
   
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

