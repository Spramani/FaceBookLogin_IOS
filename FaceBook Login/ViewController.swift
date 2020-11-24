//
//  ViewController.swift
//  FaceBook Login
//
//  Created by MAC on 24/11/20.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FBSDKCoreKit

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
                         
                let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email, name"], tokenString: token, version: nil, httpMethod: .get)
                         
                request.start(completionHandler: { connection, Result , error in
                if error == nil{
                    print("succesfully login")
                }else{
                    print(error?.localizedDescription as Any)
                }})
                }else{
                    facebookLogin.delegate = self
                    facebookLogin.permissions = ["public_profile", "email"]
                }
        
        
            }
        
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
            
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
        request.start(completionHandler: {connection, result, error in
            print("\(result)")
        })
    }
        
//        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//            if error == nil {
//                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
//                Auth.auth().signIn(with: credential) { (authResult, error) in
//                  if let error = error {
//                    print(error.localizedDescription)
//                    return
//                  }
//                    print(authResult?.user.email as Any )
//                }
//            }else{
//                print(error?.localizedDescription as Any)
//            }
//        }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            print("Error")
        }
    }
    


