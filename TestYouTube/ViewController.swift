//
//  ViewController.swift
//  TestYouTube
//
//  Created by Ruslan on 06/02/2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//

import UIKit


struct YoutubeVideo: Decodable {
    var etag: String?
    var regionCode: String?
    var items: [ItemVideo]?
}

struct ItemVideo: Decodable {
    var kind: String?
    var snippet: Snippet?
}

struct Snippet: Decodable {
    var title: String?
    var description: String?
}

struct idVideo: Decodable {
    var kind: String?
    var videoId: String?
}


class ViewController: UIViewController {
    
    var dataArray = [[String: AnyObject]]()
    // store videoid , thumbnial , Title , Description
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func getBttnTapped(_ sender: Any) {
        
        guard let videoType = textField.text else {return}
        
        // can use any text
        
        let apiKey = "AIzaSyBSemhNCkZrRwZdGP1tNEAtBongiw68iIk"
        
        // create api key from google developer console for youtube
        
        let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(videoType)&type=video&videoSyndicated=true&chart=mostPopular&maxResults=5&safeSearch=strict&order=relevance&order=viewCount&type=video&relevanceLanguage=en&regionCode=GB&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
             //   print(response)
            }
            
            guard let data = data else {return}
            //print(data)
            
            do {
                //  let json = try JSONSerialization.jsonObject(with: data, options: [])
                let youtubeVideo = try JSONDecoder().decode(YoutubeVideo.self, from: data)
                
                guard let items = youtubeVideo.items else {return}
                for i in 0..<items.count {
                    guard let title = items[i].snippet?.title else {return}
                    print(title)
                }
                
            } catch {
                print(error)
            }
            }.resume()
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    

    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableCell
        
        return cell
    }
    
    
}



// MARK: - some different code

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


// MARK: - old code

//        urlString = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
//        let targetURL = URL(string: urlString)
//
//        let config = URLSessionConfiguration.default // Session Configuration
//        let session = URLSession(configuration: config)
//
//        let task = session.dataTask(with: targetURL!) {
//
//            data, response, error in
//
//            if let response = response {
//                print(response)
//            }
//
//            if error != nil {
//
//                print(error!.localizedDescription)
//
//                let alert = UIAlertView(title: "alert", message: "No data.", delegate: nil, cancelButtonTitle: "OK")
//                alert.show()
//
//                return
//
//            }
//
//            else {
//
//                do {
//
//                    typealias JSONObject = [String:AnyObject]
//
//                    let  json = try JSONSerialization.jsonObject(with: data!, options: []) as! JSONObject
//                    let items  = json["items"] as! Array<JSONObject>
//
//                    for i in 0 ..< items.count {
//
//                        let snippetDictionary = items[i]["snippet"] as! JSONObject
//                        print(snippetDictionary)
//
//                        // Initialize a new dictionary and store the data of interest.
//                        var youVideoDict = JSONObject()
//
//                        youVideoDict["title"] = snippetDictionary["title"]
//                        youVideoDict["channelTitle"] = snippetDictionary["channelTitle"]
//                        youVideoDict["thumbnail"] = ((snippetDictionary["thumbnails"] as! JSONObject)["high"] as! JSONObject)["url"]
//                        youVideoDict["videoID"] = (items[i]["id"] as! JSONObject)["videoId"]
//
//                        self.dataArray.append(youVideoDict)
//
//                        print(self.dataArray)
//
//                        // video like can get by videoID.
//                    }
//                }
//
//                catch {
//                    print("json error: \(error)")
//                }
//            }
//        }
//        task.resume()
