//
//  StoryListTableViewController.swift
//  AndThen2
//
//  Created by Patrick Hayes on 11/20/17.
//  Copyright © 2017 Patrick Hayes. All rights reserved.
//

import UIKit

class StoryListViewController: UIViewController {

//    var testStory: [String] = ["Story 1", "Story 2", "Story 3", "Story 4", "Story 5"]
    var storyTitles = [String]()
    var author = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        StoriesModel.getAllTitles(completionHandler: {
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                    for x in jsonResult {
                        let fullDict = x as! NSDictionary
                        self.storyTitles.append(fullDict["title"]! as! String)
                        self.author.append(fullDict["author"]! as! String)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("We have an issue:  Here are the errors: \(error)")
            }
        })
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    



}

extension StoryListViewController: UITableViewDataSource {
    
    //Required for table views++++++++++++++++++++++++++++++++++++
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell", for: indexPath)
        
        //        let fullname = "\(contacts[indexPath.row].firstName!) \(contacts[indexPath.row].lastName!)"
        //        let number = contacts[indexPath.row].phoneNumber
        
        cell.textLabel?.text = "Title: '\(storyTitles[indexPath.row])'"
        cell.detailTextLabel?.text = "First Author: \(author[indexPath.row])"
        return cell
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
}
extension StoryListViewController: UITableViewDelegate {
    //++++++++++++++++++++++++++++++++++++++++++++++
    //selecting a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Cell Selected")
//        print("storyTitles array: \(storyTitles)")
//        print("author array: \(author)")
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let viewAction = UIAlertAction(title: "View", style: .default) {
            _ in
            //            self.performSegue(withIdentifier: "ViewDetails", sender: self.contacts[indexPath.row])
            //            print("This is the view sender:  \(self.contacts[indexPath.row])")
        }
//        let editAction = UIAlertAction(title: "Edit", style: .default) {
//            _ in
//            print("Edit")
            //            self.performSegue(withIdentifier: "AddContactSegue", sender: indexPath)
            
//        }
//        let deleteAction = UIAlertAction(title: "Delete", style: .default) {
//            _ in
//            print("delete")
            //            let c = self.contacts[indexPath.row]
            //            print("this is the contact \(c)")
            //            self.managedObjectContext.delete(c)
            //            do {
            //                try self.managedObjectContext.save()
            //            } catch {
            //                print("\(error)")
            //            }
            //            self.contacts.remove(at: indexPath.row)
            //            tableView.reloadData()
//        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction -> Void in
        }
        
        alert.addAction(viewAction)
        //        alert.addAction(editAction)
        //        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
}
