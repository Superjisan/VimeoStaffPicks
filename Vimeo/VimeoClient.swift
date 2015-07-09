//
//  VimeoClient.swift
//  Vimeo
//
//  Created by Jisan Zaman on 7/9/15.
//  Copyright (c) 2015 Jisan Zaman. All rights reserved.
//

import Foundation

typealias ServerResponseCallback = (videos: Array<Video>?, error: NSError?) -> Void

class VimeoClient{
    
    static let baseURLString = "https://api.vimeo.com"
    static let staffpicksPath = "/channels/staffpicks/videos"
    static let authToken = "c1964386ec61100e252ad11e9a38314e"
    
    class func staffpicks(callback: ServerResponseCallback){
        
        let URLString = baseURLString + staffpicksPath
        var URL = NSURL(string: URLString)
        
        if URL == nil{
            
            var error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to create URL"])
            callback(videos: nil, error: error)
            
            return
        }
        
        var request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"
        request.addValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if error != nil{
                    callback(videos: nil, error: error)
                    return
                }
                
                var JSONError: NSError?
                var JSON = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: &JSONError) as? Dictionary<String,AnyObject>
                
                if JSONError != nil{
                    callback(videos: nil, error: JSONError)
                    return
                }
                
                if JSON == nil {
                    var error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to parse response"])
                    callback(videos: nil, error: error)
                    return
                }
                
                var videoArray = Array<Video>()
                
                if let constJSON = JSON{
                    var dataArray = constJSON["data"] as? Array<Dictionary<String,AnyObject>>
                    
                    if let constArray = dataArray{
                        for value in constArray{
                            
                            let video = Video(dictionary: value)
                            videoArray.append(video)
                            
                        }
                    }
                }
                
                callback(videos: videoArray , error: nil)
            })
        })
        
        task.resume()
        
        
    }
}