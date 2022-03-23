//
//  ViewController.swift
//  ZSoccer
//
//  Created by Matěj Žemlička on 03.03.2022.
//

import UIKit
import AVFoundation
import Foundation
import Firebase
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class ViewController: UIViewController {
    
    final let url = URL(string: "https://api-football-v1.p.rapidapi.com/")

    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var videoLayer: UIView!
    @IBOutlet weak var lbl: UILabel!
    
    @IBAction func signIn(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
            // ...
              print("Error")
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
              performSegue(withIdentifier: "showError", sender: nil)
              print("Error")
            return
          }
        
            

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
            print("Yay!")
            performSegue(withIdentifier: "showMenu", sender: nil)
          // ...
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
    }
    
    
    
    
    
    
    
    
    func parseData() {
        let url = "https://api-football-v1.p.rapidapi.com/?rapidapi-key=2758506f2cmsh8c29540ca1126e3p11d5adjsn29d34da85e89"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print("Error")
            } else {
                do {
                    let fatchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
                    print(fatchedData)
                } catch {
                    print("Error 2")
                }
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //method for video background on login screen
    func playVideo() {
     guard let path = Bundle.main.path(forResource: "intro", ofType: "mp4") else {
     return
     }
     
     let player = AVPlayer(url: URL(fileURLWithPath: path))
     let playerLayer = AVPlayerLayer(player: player)
     playerLayer.frame = self.view.bounds
     playerLayer.videoGravity = .resizeAspectFill
     self.videoLayer.layer.addSublayer(playerLayer)
     
     player.play()
     
     videoLayer.bringSubviewToFront(lbl)
     videoLayer.bringSubviewToFront(login)
     }
}

