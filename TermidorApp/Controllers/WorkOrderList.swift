//
//  WorkOrderList.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/18/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import UIKit

class WorkOrderList: UITableViewController {
        struct Objects {
            var sectionName:String!
            var sectionObjects : [String]!
        }
        var ObjectArray = [Objects]()
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            ObjectArray = [Objects(sectionName: "New", sectionObjects: ["wfw","qfqeg","sava","egeqg"]),
                           Objects(sectionName: "Completed", sectionObjects: ["wfw","qfqeg","sava","egeqg"]),
                           Objects(sectionName: "Section3e", sectionObjects: ["wfw","qfqeg","sava","egeqg"])]
            
        }
        
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ObjectArray[section].sectionObjects.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell!
            cell?.textLabel?.text = ObjectArray[indexPath.section].sectionObjects[indexPath.row]
            return cell!
        }
        override func numberOfSections(in tableView: UITableView) -> Int {
            return ObjectArray.count
        }
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return ObjectArray[section].sectionName
        }
        
}
