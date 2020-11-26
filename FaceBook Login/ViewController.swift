//
//  ViewController.swift
//  FaceBook Login
//
//  Created by MAC on 24/11/20.
//

import UIKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController,LoginButtonDelegate {
 
//    @IBOutlet weak var facebookLogin: FBLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        facebookSetup()
       
    }
    
    @IBOutlet weak var facebookLogin: FBLoginButton!
    func facebookSetup() {
        
        if let token = AccessToken.current,!token.isExpired {
            let token = token.tokenString
                     
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":" name, email"], tokenString: token, version: nil, httpMethod: .get)
                     
            request.start(completionHandler: { connection, Result , error in
            if error == nil{
          
                print("succesfully login")
            }else{
                print(error?.localizedDescription as Any)
            }})
            }else{
                facebookLogin.delegate = self
                facebookLogin.permissions = ["public_profile","email"]
            }
        }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if error == nil {
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                Auth.auth().signIn(with: credential) { (authResult, error) in
                  if let error = error {
                    print(error.localizedDescription)
                    return
                  }
                    let name = authResult?.user.displayName!
                    let email = authResult?.user.email!
                    let photo = authResult?.user.photoURL!
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                           let detail:secondVC = storyboard.instantiateViewController(withIdentifier: "secondVC") as! secondVC
                    detail.l11 = name
                    detail.l22 = email
                    detail.l33 = photo
                           self.navigationController?.pushViewController(detail, animated: true)
                    
                    print("Successfully Login")
                }
            }else{
                print(error?.localizedDescription as Any)
            }
        }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        let firebaseAuth = Auth.auth()
              do {
                  try firebaseAuth.signOut()
             
                  print("signOut")

              } catch let signOutError as NSError {
                  print ("Error signing out: %@", signOutError)
              }
    }
}
