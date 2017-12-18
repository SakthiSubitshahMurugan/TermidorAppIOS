//
//  HomeViewController.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/14/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import UIKit
import CoreData
import SwiftKeychainWrapper

class HomeViewController: UIViewController {
    var managedObjectContext: NSManagedObjectContext? = nil
    var PersistenStoredCordinator = CoreDataStack.sharedInstance.persistentContainer
    let context  = CoreDataStack.sharedInstance.persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func Log(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
         resetAllRecords(in:"UserData")
         resetAllRecords(in: "InjectionStation")
        resetAllRecords(in: "TermicideType")
        let _: Bool = KeychainWrapper.standard.removeObject(forKey: "token")
        Base.sharedInstance.Token = "NA"
        
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDel.window?.rootViewController = loginVC
        
    }
    
    func resetAllRecords(in entity : String){
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        Base.sharedInstance.TermicidetypeObj.removeAll()
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
}
