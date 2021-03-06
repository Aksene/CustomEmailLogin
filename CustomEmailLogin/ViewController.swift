//
//  ViewController.swift
//  CustomEmailLogin
//
//  Created by Abdou on 6/18/21.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        // Flip the boolean
        isSignIn = !isSignIn
        
        //Check the bool and set the button and labels
        if isSignIn{
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else{
            // Register the user with firebase
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        // TODO: Do some form validation on the email and password
        
        //Use optional binding to check if contains email & password
        if let email = emailTextField.text, let pass = passwordTextField.text{
            //Check if it's sign in or register
            if isSignIn{
                //Sign in the user with Firebase
                Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                    
                    // Check that user isn't nil
                    if let u = user{
                        // User is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else{
                        // Error: check error and show message
                    }
                }
            }
            else{
                // Register the user with firebase
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    
                    // Check that user isn't nil
                    if let u = user{
                        // User is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else{
                        // Error: check error and show message
                    }
                }
                
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

