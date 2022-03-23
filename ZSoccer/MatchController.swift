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
    
    private var team: [Match] = []
    
    override func viewDidLoad() {
        tvMatches.delegate = self
        tvMatches.dataSource = self
        fetchMatches(date: Date())
    }
    
    func fetchMatches(date: Date){
        
        self.team = []
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let newDate = dateFormatter.string(from: date)
    
    let headers: HTTPHeaders = [
        "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com",
        "X-RapidAPI-Key": "2758506f2cmsh8c29540ca1126e3p11d5adjsn29d34da85e89"
    ]
        let today = Date()
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: today)
        let url = "https://api-football-v1.p.rapidapi.com/v3/fixtures?date="
    
    AF.request(url + newDate, headers: headers).responseJSON {
        (response) in let json = try! JSON(data: response.data!)
        
        print(json)
        
        let arr = json["response"].arrayValue
        
        for team in arr {
            let a = Match(name1: team["teams"]["home"]["name"].stringValue,
                         logo1: team["teams"]["home"]["logo"].stringValue,
                        name2: team["teams"]["away"]["name"].stringValue,
                        logo2: team["teams"]["away"]["logo"].stringValue,
                         score1: team["goals"]["home"].intValue,
                          score2: team["goals"]["away"].intValue)
                        
                
            self.team.append(a)
            
        }
        self.tvMatches.reloadData()
        
    }
}

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell: MatchCell = tvMatches.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as! MatchCell
        
        cell.nameLbl.text = team[indexPath.item].name1
        cell.nameLbl2.text = team[indexPath.item].name2
        
        getData(from: URL(string: team[indexPath.item].logo1)!) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                cell.imgView1.image = UIImage(data: data)
            }
        }
        getData(from: URL(string: team[indexPath.item].logo2)!) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                cell.imgView2.image = UIImage(data: data)
            }
        }
        
        cell.scoreLbl.text = String(team[indexPath.item].score1)
        cell.scoreLbl2.text = String(team[indexPath.item].score2)
        
        return cell
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            fetchMatches(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        } else if sender.selectedSegmentIndex == 1 {
            fetchMatches(date: Date())
        } else if sender.selectedSegmentIndex == 2 {
            fetchMatches(date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

