//
//  ProductHuntManager.swift
//  Created by Pushpsen Airekar on 26/1/20.
//  Copyright © 2020 Pushpsen Airekar. All rights reserved.
//

// MARK: - Importing Frameworks.

import Foundation
import Alamofire
import SwiftyJSON

 // MARK: - Declaration of Enums

enum Day {
    case today
    case yesterday
    case twoDaysAgo
    case threeDaysAgo
}

/* ----------------------------------------------------------------------------------- */

class ProductHuntManager {
    
     // MARK: - Declaration of typealias
    public typealias postResult = (_ success: [Post]?, _ error: Error?) ->Void
    public typealias commentResult = (_ success: [Comment]?, _ error: Error?) ->Void
    
    
    /**
    This method fetched the posts as per the day provided by the user
    - Parameters:
       - day: day specifies an enum which has values such as `.today`,`.yesterday`,`.twoDaysAgo`,`threeDaysAgo`
       - completionHandler: this handler provides an update when method completes his operation
    - Author: Pushpsen Airekar
    - Copyright: Copyright © 2020 Pushpsen Airekar
    */
    func fetchPosts(for day: Day, completionHandler: @escaping postResult){
        let parameters: Parameters = ["access_token": AppConstants.token]
        var url = AppConstants.url
        if day == .today{
            url = AppConstants.url
        }else if day == .yesterday{
            url = AppConstants.url + "?days_ago=1"
        }else if day == .twoDaysAgo{
            url = AppConstants.url + "?days_ago=2"
        }else if day == .threeDaysAgo {
            url = AppConstants.url + "?days_ago=3"
        }
        Alamofire.request(url, method : .get, parameters : parameters).responseJSON{
            response in
            if response.result.isSuccess{
                var posts = [Post]()
                let postsJSON : JSON = JSON(response.result.value!)
                for i in 0..<postsJSON["posts"].count{
                    let pid = postsJSON["posts"][i]["id"].stringValue
                    let uid = postsJSON["posts"][i]["user"]["id"].stringValue
                    let title = postsJSON["posts"][i]["name"].stringValue
                    let message = postsJSON["posts"][i]["tagline"].stringValue
                    let commentsCount = postsJSON["posts"][i]["comments_count"].intValue
                    let imageURL = postsJSON["posts"][i]["thumbnail"]["image_url"].stringValue
                    let post = Post(uid: uid, pid: pid, title: title, message: message, count: commentsCount, imageURL: imageURL)
                    posts.append(post)
                }
                completionHandler(posts,nil)
            }else{
                completionHandler(nil,response.result.error)
            }
        }
    }
    
    /**
     This method fetched the comments  as per the post id provided by the user
     - Parameters:
        - day: day specifies an enum which has values such as `.today`,`.yesterday`,`.twoDaysAgo`,`threeDaysAgo`
        - completionHandler: this handler provides an update when method completes his operation
     - Author: Pushpsen Airekar
     - Copyright: Copyright © 2020 Pushpsen Airekar
     */
    func fetchComments(forPost pid: String, completionHandler: @escaping commentResult){
        let commentURL = "https://api.producthunt.com/v1/comments?search[post_id]=\(pid)"
        let parameters: Parameters = ["access_token": AppConstants.token]
        Alamofire.request(commentURL, method : .get, parameters : parameters).responseJSON{
            response in
            if response.result.isSuccess{
                print("Success! Got the comments data: \(response)")
                let commentsJSON : JSON = JSON(response.result.value!)
                var comments = [Comment]()
                for i in 0..<commentsJSON["comments"].count{
                    let name = commentsJSON["comments"][i]["user"]["name"].stringValue
                    let avatar = commentsJSON["comments"][i]["user"]["image_url"]["100px"].stringValue
                    let profession = commentsJSON["comments"][i]["user"]["headline"].stringValue
                    let comment = commentsJSON["comments"][i]["body"].stringValue
                    let uid = commentsJSON["comments"][i]["user_id"].stringValue
                    _ = commentsJSON["comments"][i]["votes"].intValue
                    let time = commentsJSON["comments"][i]["created_at"].stringValue
                    let newComment = Comment(uid: uid, name: name, profession: profession, avatar: avatar, comment: comment, time: time)
                    comments.append(newComment)
                }
                completionHandler(comments,nil)
            }else{
                completionHandler(nil,response.error)
            }
        }
    }
}

/* ----------------------------------------------------------------------------------- */
