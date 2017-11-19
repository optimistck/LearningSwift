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
    
    func displayAlert(title: String, message: String) {
        
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertcontroller, animated: true, completion: nil)
        
    }
    
    var signUpMode = true
    
    @IBOutlet var signupOrLoginButton: UIButton!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var isDriverSwitch: UISwitch!
    @IBAction func signupOrLogin(_ sender: Any) {
        
        if usernameTextField.text == "" || passwordTextField.text == "" {
            
            displayAlert(title: "Error in form", message: "Username and password are required")
            
        } else {
            
            if signUpMode {
                
                let user = PFUser()
                
                user.username = usernameTextField.text
                user.password = passwordTextField.text
                
                user["isDriver"] = isDriverSwitch.isOn
                
                user.signUpInBackground(block: { (success, error) in
                    
                    if let error = error {
                        
                        var  displayedErrorMessage = "please try again later"
                        
                        if let paraseError = error.localizedDescription as? String { 
                            
                            displayedErrorMessage = paraseError
                            
                        }
                        
                        self.displayAlert(title: "Sign Up Failed", message: displayedErrorMessage)
                        
                    } else {
                        
                        print("Signup successful")
                        
                        if let isDriver = PFUser.current()?["isDriver"] as? Bool {
                            
                            if isDriver {
                                
                                self.performSegue(withIdentifier: "showDriverViewController", sender: self)
                                
                            } else {
                                
                                self.performSegue(withIdentifier: "showRiderViewController", sender: self)
                                
                            }
                            
                            
                        }
                        
                        
                    }
                    
                })
                
            } else {
                
                PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    if let error = error {
                        
                        var  displayedErrorMessage = "please try again later"
                        
                        if let paraseError = error.localizedDescription as? String {
                            
                            displayedErrorMessage = paraseError
                            
                        }
                        
                        self.displayAlert(title: "Sign Up Failed", message: displayedErrorMessage)
                        
                    } else {
                        
                        print("Log In successful")
                        
                        if let isDriver = PFUser.current()?["isDriver"] as? Bool {
                            
                            if isDriver {
                                
                                self.performSegue(withIdentifier: "showDriverViewController", sender: self)
                                
                            } else {
                                
                                self.performSegue(withIdentifier: "showRiderViewController", sender: self)
                                
                            }
                            
                            
                        }
                        
                        
                    }
                    
                })
                
            }
            
        }
        
        
    }

    @IBOutlet var signupSwitchButton: UIButton!
    @IBOutlet var riderLabel: UILabel!
    @IBOutlet var driverLabel: UILabel!
    
    
    
    @IBAction func switchSignupMode(_ sender: Any) {
        
        if signUpMode {
            
            signupOrLoginButton.setTitle("Log In", for: [])
            
            signupSwitchButton.setTitle("Swith to Sign Up", for: [])
            
            signUpMode = false
            
            isDriverSwitch.isHidden = true
            
            riderLabel.isHidden = true
            
            driverLabel.isHidden = true
            
            
            
        } else { //we're not in the sign-up mode, because we're in the login mode
            
            signupOrLoginButton.setTitle("Sign Up", for: [])
            
            signupSwitchButton.setTitle("Swith to Login", for: [])
            
            signUpMode = true
            
            isDriverSwitch.isHidden = false
            
            riderLabel.isHidden = false
            
            driverLabel.isHidden = false
            
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if let isDriver = PFUser.current()?["isDriver"] as? Bool {
            
            if isDriver {
                
                performSegue(withIdentifier: "showDriverViewController", sender: self)
                
            } else {
                
                self.performSegue(withIdentifier: "showRiderViewController", sender: self)
                
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
