//
//  UserDetailsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Constantin on 12/29/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class UserDetailsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var errorLabel: UILabel!
    
    @IBOutlet var userImage: UIImageView!
    
    @IBAction func updateProfileImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        
        // set the picker back to the ViewController
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    //now do something with the image. Type / search for didFinishPic...
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            userImage.image = image
            
        }
        
        //dismiss the new controller that we created either way (that's the image picker)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet var genderSwitch: UISwitch!
    
    
    @IBOutlet var interestedInSwitch: UISwitch!
    
    @IBAction func update(_ sender: Any) {
        
        PFUser.current()?["isFemale"] = genderSwitch.isOn
        
        PFUser.current()?["isInterestedInWomen"] = interestedInSwitch.isOn
        
        let imageData = UIImagePNGRepresentation(userImage.image!)
        
        PFUser.current()?["photo"] = PFFile(name: "profile.png", data: imageData!)
        
        PFUser.current()?.saveInBackground(block: { (success, error) in
        
            
            if error != nil {
                
                var errorMessage = "Update failed - try again"
                
                let error = error as NSError?
                
                if let paraseError = error?.userInfo["error"] as? String {
                    
                    errorMessage = paraseError
                    
                }
                
                self.errorLabel.text = errorMessage
                
            } else {
                
                print("Updated")
                
                self.performSegue(withIdentifier: "showSwipingViewController", sender: self)
                
            }
        
        })
    
        //print(genderSwitch.isOn)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // check to see if the user has entered a few details about itself. If so, set the items.
        
        if let isFemale = PFUser.current()?["isFemale"] as? Bool {
            
            genderSwitch.setOn(isFemale, animated: false)
       
        }

        if let isInterestedInWomen = PFUser.current()?["isInterestedInWomen"] as? Bool {
            
            interestedInSwitch.setOn(isInterestedInWomen, animated: false)
            
        }
        
        //get profile picture
        
        if let photo = PFUser.current()?["photo"] as? PFFile {
            
            photo.getDataInBackground(block: { (data, error) in
                
                //not checking for errors, but should, tim
                if let imageData = data {
                    
                    if let downloadImage = UIImage(data: imageData) {
                        
                        self.userImage.image = downloadImage
                        
                    }
                    
                }
                
            })
            
        }
        
        // code to download images and create somee users
        
        /*********
        let urlArray = ["http://static1.comicvine.com/uploads/square_small/0/2617/103863-63963-torongo-leela.JPG", "http://previews.123rf.com/images/lordalea/lordalea1209/lordalea120900002/15046660-Mujer-de-negocios-moderna-Vector-Illustration-Foto-de-archivo.jpg", "http://www.polyvore.com/cgi/img-thing?.out=jpg&size=l&tid=44643840", "https://larryfire.files.wordpress.com/2009/03/disney20jessica20rabbit.jpg%3Fw%3D450", "http://s.orzzzz.com/news/7c/2a//564431e9b13ed.jpg", "http://www.fanpup.me/uploads/2/3/5/9/23592480/1952153.jpg?238", "http://1.bp.blogspot.com/-BexbS2zf8gg/UvhqZQf_brI/AAAAAAAAIBc/fwBtuk809SY/s1600/Sailor+Moon+&+Molly.png"]
        
        var counter = 0
        
        for urlString in urlArray {
            
            counter += 1
            
            //different way than before
            
            let url = URL(string: urlString)!
            
            do {
                
            let data = try Data(contentsOf: url)
                
                let imageFile = PFFile(name: "photo.png", data: data)
                
                let user = PFUser()
                
                user["photo"] = imageFile
                
                user.username = String(counter)
                
                user.password = "password"
                
                user["isInterestedInWomen"] = false
                
                user["isFemale"] = true
                
                let acl = PFACL()
                
                acl.getPublicWriteAccess = true
                
                user.acl = acl
                
                user.signUpInBackground(block: { (success, error) in
                    
                    if success {
                        
                        print("User signed up")
                        
                    }
                    
                })
                
                
            } catch {
            
                
                
            }
            
        }
        ************/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
