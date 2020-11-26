//
//  secondVC.swift
//  FaceBook Login
//
//  Created by MAC on 25/11/20.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FBSDKCoreKit

class secondVC: UIViewController{
    
    var l11 : String!
    var l22 : String!
    var l33 : URL!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var ll2: UILabel!
    @IBOutlet weak var ll1: UILabel!
    @IBAction func logOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        let firebaseAuth = Auth.auth()
              do {
                  try firebaseAuth.signOut()
               
                  print("signOut")

              } catch let signOutError as NSError {
                  print ("Error signing out: %@", signOutError)
              }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detail:ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(detail, animated: true)
      
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        img.layer.cornerRadius = 50
        img.layer.borderWidth = 2
        img.clipsToBounds = true
        
        ll1.text = l11
        ll2.text = l22
        let url = l33
        
        
           // Fetch Image Data
           if let data = try? Data(contentsOf: url!) {
               // Create Image and Update Image View
        
            img.image = UIImage(data: data)
        
        
      
           }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Error")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
