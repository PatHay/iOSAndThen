//
//  Stories.swift
//  AndThen2
//
//  Created by Patrick Hayes on 11/20/17.
//  Copyright © 2017 Patrick Hayes. All rights reserved.
//

import Foundation
class StoriesModel {
    // Note that we are passing in a function to the getAllStories method (similar to our use of callbacks in JS). This function will allow the ViewController that calls this method to dictate what runs upon completion.
    static func getAllTitles(completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        //specified url for the get request
        let url = URL(string: "http://52.15.173.121/stories")
        // created URLSession to handle the request tasks
        let session = URLSession.shared
        // Create a "data task" which will request some data from a URL and then run the completion handler that we are passing into the getAllStories function itself
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()
        
        }
}
