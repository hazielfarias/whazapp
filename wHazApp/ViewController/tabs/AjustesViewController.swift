//
//  AjustesViewController.swift
//  wHazApp
//
//  Created by Haziel Leite Farias on 14/08/19.
//  Copyright © 2019 Haziel. All rights reserved.
//

import UIKit
import FirebaseAuth

class AjustesViewController: UIViewController {

    var auth: Auth!
    
    @IBAction func deslogar(_ sender: Any) {
        self.auth = Auth.auth()
        do {
            try self.auth.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch {
            print("Erro ao deslogar")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
