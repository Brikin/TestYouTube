//
//  ViewController.swift
//  TestYouTube
//
//  Created by Ruslan on 06/02/2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func getBttnTapped(_ sender: Any) {
        //        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        //        let session = URLSession.shared
        //        session.dataTask(with: url) { (data, response, error) in
        //            if let response = response {
        //                print(response)
        //            }
        //
        //            guard let data = data else {return}
        //            print(data)
        //
        //            do {
        //                let json = try JSONSerialization.jsonObject(with: data, options: [])
        //                print(json)
        //            } catch {
        //                print(error)
        //            }
        //            }.resume()
        
        let videoType = "borsh"
        
        // can use any text
        
        var dataArray = [[String: AnyObject]]()
        // store videoid , thumbnial , Title , Description
        
        let apiKey = "AIzaSyBSemhNCkZrRwZdGP1tNEAtBongiw68iIk"
        
        // create api key from google developer console for youtube
        
        var urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(videoType)&type=video&videoSyndicated=true&chart=mostPopular&maxResults=10&safeSearch=strict&order=relevance&order=viewCount&type=video&relevanceLanguage=en&regionCode=GB&key=\(apiKey)"
        
        
        urlString = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
        let targetURL = URL(string: urlString)
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: targetURL!) {
            
            data, response, error in
            
            if let response = response {
                print(response)
            }
            
            if error != nil {
                
                print(error!.localizedDescription)

                let alert = UIAlertView(title: "alert", message: "No data.", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                
                return
                
            }
                
            else {
                
                do {
                    
                    typealias JSONObject = [String:AnyObject]
                    
                    let  json = try JSONSerialization.jsonObject(with: data!, options: []) as! JSONObject
                    let items  = json["items"] as! Array<JSONObject>
                    
                    for i in 0 ..< items.count {
                        
                        let snippetDictionary = items[i]["snippet"] as! JSONObject
                        print(snippetDictionary)
                        // Initialize a new dictionary and store the data of interest.
                        var youVideoDict = JSONObject()
                        
                        youVideoDict["title"] = snippetDictionary["title"]
                        youVideoDict["channelTitle"] = snippetDictionary["channelTitle"]
                        youVideoDict["thumbnail"] = ((snippetDictionary["thumbnails"] as! JSONObject)["high"] as! JSONObject)["url"]
                        youVideoDict["videoID"] = (items[i]["id"] as! JSONObject)["videoId"]
                
                        dataArray.append(youVideoDict)
                        
                        print(dataArray)
                        
                        // video like can get by videoID.
                        
                    }
                }
                    
                catch {
                    print("json error: \(error)")
                }
            }
        }
        task.resume()
    }
    

    
    
}

