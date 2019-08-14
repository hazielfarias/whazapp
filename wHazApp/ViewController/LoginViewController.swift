//
//  LoginViewController.swift
//  wHazApp
//
//  Created by Haziel Leite Farias on 14/08/19.
//  Copyright © 2019 Haziel. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var campoSenha: UITextField!
    @IBOutlet weak var scrollPrincipal: UIScrollView!
    
    var auth: Auth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScroll(notification:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(diminuirScroll(notification:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        
        self.auth = Auth.auth()
        
        
        
        self.auth.addStateDidChangeListener { (autenticacao, usuario) in
            if usuario != nil{
                self.performSegue(withIdentifier: "segueLoginAutomatico", sender: nil)
            }
        }
        if let usuarioAtual = self.auth.currentUser?.email{
            print(usuarioAtual)}
    }
    
    @IBAction func logar(_ sender: Any) {
        if let email = self.campoEmail.text{
            if let senha = self.campoSenha.text{
                self.auth.signIn(withEmail: email, password: senha) { (usuario, erro) in
                    if erro == nil{
                        if let usuarioLogado = usuario{
                            print("Sucesso ao logar usuário \(String(describing: usuarioLogado.user.email))")
                        }
                    }else{
                        print("Erro ao autenticar usuário")
                    }
                }
            }else{
                print("Digite uma senha")
            }
        }else{
            print("Digite um email")
        }
    }
    
    @objc func aumentarScroll(notification: Notification){
        self.scrollPrincipal.contentSize = CGSize(width: self.scrollPrincipal.frame.width, height: self.scrollPrincipal.frame.height + 100)
        self.scrollPrincipal.isScrollEnabled = true
        
    }
    @objc func diminuirScroll(notification: Notification){
        self.scrollPrincipal.contentSize = CGSize(width: self.scrollPrincipal.frame.width, height: self.scrollPrincipal.frame.height - 100)
        self.scrollPrincipal.isScrollEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
