/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupMode = true
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signupOrLoginButton: UIButton!
    @IBOutlet var changeSignupModeButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    
    @IBAction func signupOrLogin(_ sender: Any) {
        
        
        if signupMode {
        
        
            //we're not doing the check if the username and password field is empty
        
            let user = PFUser()
        
            user.username = usernameField.text
            user.password = passwordField.text
            
            let acl = PFACL()
            
            //this allows anyone to write to this object, only what our app allows to do.
            /**** this didn't seem to matter to my version of the code ****/
            
            acl.getPublicWriteAccess = true
            acl.getPublicReadAccess = true
            user.acl = acl
        
            
            
            user.signUpInBackground { (success, error) in
            
                if error != nil {
                
                    //just for variety...
                    var errorMessage = "Sign up failed  try again"
                    
                    let error = error as NSError?
                
                    if let paraseError = error?.userInfo["error"] as? String {
                    
                        errorMessage = paraseError
                    
                    }
                
                    self.errorLabel.text = errorMessage
                
                } else {
                
                    print("Signed up")
                    //no need to redirect here, since they haven't given us the details.
                    self.performSegue(withIdentifier: "goToUserInfo", sender: self)
                    
                }
            }
    
        } else {
    
            PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!, block: { (user, error) in
                
                if error != nil {
                    
                    var errorMessage = "Login failed  try again"
                    
                    let error = error as NSError?
                    
                    if let paraseError = error?.userInfo["error"] as? String {
                        
                        errorMessage = paraseError
                        
                    }
                    
                    self.errorLabel.text = errorMessage
                    
                } else {
                    
                    print("Logged In")
                    self.redirectUser()
                    //changed to above
                    //self.performSegue(withIdentifier: "goToUserInfo", sender: self)
                    
                }
                
            })
            
        }
    }
    
    @IBAction func changeSignupMode(_ sender: Any) {
        
        if signupMode { //we're in the sign up mode
            
            signupMode = false
            
            signupOrLoginButton.setTitle("Log In", for: [])
            
            changeSignupModeButton.setTitle("Sign Up", for: [])
            
            
        } else { //we're in the login mode
            
            signupMode = true
            
            signupOrLoginButton.setTitle("Sign Up", for: [])
            
            changeSignupModeButton.setTitle("Log In", for: [])
            
            
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        redirectUser()
        
    }
    
    func redirectUser() {
        
        if PFUser.current() != nil {
            
            if PFUser.current()?["isFemale"] != nil && PFUser.current()?["isInterestedInWomen"] != nil && PFUser.current()?["photo"] != nil {
                // if the user has put in their profile details, then we want to show them the swiping ViewController
                performSegue(withIdentifier: "swipeFromInitialSegue", sender: self)
                
            } else {
                
                performSegue(withIdentifier: "goToUserInfo", sender: self)
            }
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        


        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
