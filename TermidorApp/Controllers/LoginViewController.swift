//
//  ViewController.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/6/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON
import Alamofire
import Toast_Swift
import SwiftKeychainWrapper
import BEMCheckBox
import SVProgressHUD
import MBProgressHUD
import RNCryptor



class LoginViewController: UIViewController{
    let defaults: UserDefaults? = UserDefaults.standard
    @IBOutlet weak var rememberMe: BEMCheckBox!
    @IBOutlet weak var userName: InsetTextField!
    @IBOutlet weak var passWord: InsetTextField!
    @IBAction func checkBox(_ sender: BEMCheckBox) {
          defaults?.set(true, forKey: "rememberME")
          defaults?.set(userName.text, forKey: "SavedUserName")
          defaults?.set(passWord.text, forKey: "SavedPassword")
          defaults?.synchronize()
    }
    var managedObjectContext: NSManagedObjectContext? = nil
    var PersistenStoredCordinator = CoreDataStack.sharedInstance.persistentContainer
    let context  = CoreDataStack.sharedInstance.persistentContainer.viewContext
    var result:String?
    override func viewDidLoad() {
        print("bwrbrw")
        super.viewDidLoad()
        userName.delegate = self as? UITextFieldDelegate
        passWord.delegate = self as? UITextFieldDelegate
        self.title = "Login"
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red:1.58, green: 0.1, blue: 0.28, alpha: 1)
        rememberMe.tintColor = UIColor.black
        rememberMe.onFillColor = UIColor.clear
        rememberMe.onCheckColor = UIColor(displayP3Red: 1.58, green: 0.1, blue: 0.28, alpha: 1)
        rememberMe.onTintColor = UIColor(displayP3Red: 1.58, green: 0.1, blue: 0.28, alpha: 1)
        rememberMe.boxType = BEMBoxType.square
        rememberMe.lineWidth = 0.5
        do{
            if(defaults?.bool(forKey: "rememberME"))!{
                userName.text = defaults?.value(forKey: "SavedUserName") as? String
                print(userName.text!)
                passWord.text = defaults?.value(forKey: "SavedPassword") as? String
                print(passWord.text)
            }
        } }
    @IBAction func UserLogin(_ sender: Any){
        if isConnectedToNetwork() {
            let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
            loadingNotification.label.text = "Loading"
//            do {
//                let UserData1 = try context.fetch(UserData.fetchRequest()) as! [UserData]
//                print (UserData1.count)
//                if(UserData1.count != 0){
//                    print(UserData1.last)
//                    print("jvhdhjevbw")
//                    print(UserData1.last?.password)
//                    if(passWord.text == UserData1.last?.password && KeychainWrapper.standard.string(forKey: "token")  != nil){
//                        print("same pasword")
//                        Base.sharedInstance.Token = KeychainWrapper.standard.string(forKey: "token")!
//                    }else{
//                        self.view.makeToast("Invalid UserName or Password", duration: 3.0, position: .bottom)
//                    }
//                }else{
//                    Base.sharedInstance.Token = "NA"
//                }
//            }catch let error as NSError {
//                print("Error: \(error.debugDescription)")
//            }
            UserAuth(token:Base.sharedInstance.Token, UserLoginUrl: "gfdfgdgfdg", password: passWord.text!, username: userName.text!, completion: { (true) in
                if( Base.sharedInstance.ServiceAvailabilty == "N"){
                     self.view.makeToast("No Service Available", duration: 3.0, position: .top)
                     MBProgressHUD.hideAllHUDs(for: self.view, animated: true);
                }else if( Base.sharedInstance.result != nil){
                     self.view.makeToast("Invalid UserName or Password", duration: 3.0, position: .top)
                    Base.sharedInstance.result = nil
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true);
                }else{
                    if(Base.sharedInstance.result == nil){
                        self.SaveUserData()
                        LoadInjectionStation(Url: "vhejk", username: self.userName.text!, password: self.passWord.text!,completion: {(true) in
                                        self.SaveInjectionSationData()
                            })
                         LoadTermicideTypes(Url: "ghdh", username: self.userName.text!, password: self.passWord.text!, completion: { (true) in
                            self.SaveDataTermicideType()
                            MBProgressHUD.hideAllHUDs(for: self.view, animated: true);
                          

                        })
                        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let centerVC = mainStoryBoard.instantiateViewController(withIdentifier: "DisclaimerViewController") as! DisclaimerViewController
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.synchronize()
                        appDel.window!.rootViewController = centerVC
                        appDel.window!.makeKeyAndVisible()
                    }
                }
                
            })
            print("completed")
             SVProgressHUD.dismiss()
        }
        else {
            self.view.makeToast("No Network connection", duration: 3.0, position: .top)
        }
    }
    func SaveUserData(){
       resetAllRecords(in:"UserData")
        let BaseObject = Base.sharedInstance.Global!
        let task = UserData(context: self.context)
        task.firstName = BaseObject.firstName!
        task.groupID = BaseObject.groupID!
        task.canDoTraining = BaseObject.canDoTraining!
        task.mobileAppVersion = BaseObject.mobileAppVersion!
        task.groupName = BaseObject.groupName!
        task.lastName = BaseObject.lastName!
        task.personID = BaseObject.personID!
        task.userRoleCode = BaseObject.userRoleCode!
        task.userSubRoleCode = BaseObject.userSubRoleCode!
            do {
                let _ = try context.fetch(UserData.fetchRequest()) as! [UserData]
          }
           catch {
               print("Fetching Failed")
            }
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
    func entityIsEmpty(entity: String) -> Bool
    {
        let context = NSManagedObjectContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        var results : NSArray?
        do {
            results = try context.fetch(request) as! [NSManagedObject] as NSArray
            return results!.count == 0
            
        }catch let error as NSError {
            print("Error: \(error.debugDescription)")
            return true
        }
    }
    
   func SaveInjectionSationData(){
    //resetAllRecords(in:"InjectionStation")
    let BaseObject = Base.sharedInstance.InjectionStationObj
    // print (BaseObject.count)
    let task = InjectionStation(context:self.context)
     for i in BaseObject{
      task.injectionStationID = i.injectionStationID
      task.injectionStationName = i.injectionStationName
      task.iPAddress = i.iPAddress
      task.controllerIPAddress = i.controllerIPAddress
    }
        do {
            let inject = try context.fetch(InjectionStation.fetchRequest()) as! [InjectionStation]
            if (inject.count > 0) {
                for _ in inject{
                }
            }
      }
       catch {
           print("Fetching Failed")
        }
   }

func SaveDataTermicideType(){
   // resetAllRecords(in:"TermicideType")
    let BaseObject = Base.sharedInstance.TermicidetypeObj
   // print(BaseObject.count)
    let task = TermicideType(context:self.context)
    for i in BaseObject{
        //print(i)
        task.termicideTypeCode = i.termicideTypeCode
        task.termicideTypeName = i.termicideTypeName
        task.dilutionRatio = i.dilutionRatio
        task.injectionCountFactor = i.injectionCountFactor
}
    do {
        let inject1 = try context.fetch(TermicideType.fetchRequest()) as! [TermicideType]
        for _ in inject1{
        }
    }
    catch {
        print("Fetching Failed")
    }
    
}
    
 
}
