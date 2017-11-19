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
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func signupOrLogin(_ sender: Any) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            
           createAlert(title: "Error in form", message: "Please enter email and password")
            
        } else {
            // go on and attempt to sign-up.
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            
            if signupMode {
                // Sign-up mode, so sign the user up
                
                let user = PFUser()
                
                user.username = emailTextField.text //required
                user.email = emailTextField.text //optional
                user.password = passwordTextField.text
                user.signUpInBackground(block: { (success, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        //self.createAlert(title: "Error in form", message: "Parser Error")
                        
                        var displayErrorMessage = "Please try again"
                        
                        /*
                        if let errorMessage = error?.userInfo["error"] as? String {
                            displayErrorMessage = errorMessage
                        }
                        */
                        
                        self.createAlert(title: "Sign up error", message: displayErrorMessage)
                        
                    } else {
                        
                        print("User signed up")
                        
                    }
                    
                })
                
            } else {
                // Login mode
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        var displayErrorMessage = "Please try again"
                        
                        /*
                         if let errorMessage = error?.userInfo["error"] as? String {
                         displayErrorMessage = errorMessage
                         }
                        */
                        
                        self.createAlert(title: "Login Error", message: displayErrorMessage)
                    } else {
                        print("Logged in")
                    }
                    
                })
            }
        }
        
    }
    @IBAction func changeSignupMode(_ sender: Any) {
        
        if signupMode {
            
            // change to login mode
            
            signupOrLogin.setTitle("Log In", for: [])
            
            changeSignupModeButton.setTitle("Sign Up", for: [])
            
            messageLabel.text = "Don't have an account?"
            
            signupMode = false
            
        } else {
            // must be in login mode
            // change to sign-up mode
            signupOrLogin.setTitle("Sign Up", for: [])
            changeSignupModeButton.setTitle("Log In", for: [])
            messageLabel.text = "Already have an account??"
            signupMode = true
        
        }
    }
    
    @IBOutlet var signupOrLogin: UIButton!
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var changeSignupModeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
