//
//  DisclaimerViewController.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/12/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import UIKit
import CoreData

class DisclaimerViewController: UIViewController {
    var managedObjectContext: NSManagedObjectContext? = nil
    var PersistenStoredCordinator = CoreDataStack.sharedInstance.persistentContainer
    let context  = CoreDataStack.sharedInstance.persistentContainer.viewContext

    var count = 0
    
    @IBOutlet weak var CautionLabel: UILabel!
    @IBOutlet weak var CautionText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 20
        style.alignment = .center
    
        let attributes = [NSAttributedStringKey.paragraphStyle : style,
                          NSAttributedStringKey.font : UIFont(name: "Helvetica Neue", size: 26.0)!,
                          NSAttributedStringKey.foregroundColor:  UIColor.black]
        CautionText.attributedText = NSAttributedString(string:CautionText.text, attributes: attributes)
        //self.navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(DisclaimerViewController.tapFunction))
        CautionLabel.isUserInteractionEnabled = true
        CautionLabel.addGestureRecognizer(tap)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
        count = count+1
        if (count==7){
            count = 0
            let alert = UIAlertController(title: "Caution", message: "Would you like to delete the complete Database?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler:{ (action: UIAlertAction!) in
                self.resetAllRecords(in: "UserData")
                self.resetAllRecords(in: "TermicideType")
                self.resetAllRecords(in: "InjectionStation")
               
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
   
    func resetAllRecords(in entity : String){
        print("deleting")
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
