//
//  LoginController.swift
//  tren
//
//  Created by Hasan onur Can on 8.02.2022.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    @IBOutlet weak var epostaLabel: UITextField!
    
    @IBOutlet weak var sifreLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
}
    @IBAction func girisPressed(_ sender: UIButton) {
        
        if let email = epostaLabel.text, let password = sifreLabel.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e)
                }else{
                    self.performSegue(withIdentifier: "ToWellcome", sender: self)
                }
            }
        
        
    }
    }
    @IBAction func kayıtolPressed(_ sender: UIButton) {
        if let email = epostaLabel.text, let password = sifreLabel.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e=error{
                    print(e)
                }else{
                    self.performSegue(withIdentifier: "ToWellcome", sender: self)
                }
            }
                
            
        
        
        
         
        }
    }
    
    
    
}

