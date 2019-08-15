//
//  CadastroViewController.swift
//  wHazApp
//
//  Created by Haziel Leite Farias on 14/08/19.
//  Copyright © 2019 Haziel. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CadastroViewController: UIViewController {

    
    @IBOutlet weak var campoNome: UITextField!
    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var campoSenha: UITextField!
    @IBOutlet weak var scrollPrincipal: UIScrollView!
    
    var auth: Auth!
    var database: Database!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScroll(notification:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(diminuirScroll(notification:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        
        self.auth = Auth.auth()
        self.database = Database.database()
    }
    
    @IBAction func cadastrar(_ sender: Any) {
        
        if let nome = self.campoNome.text{
            if let email = self.campoEmail.text{
                if let senha = self.campoSenha.text{
                    
                    self.auth.createUser(withEmail: email, password: senha, completion: {(usuario, erro) in
                        if erro == nil{
                            
                            var usuario: Dictionary<String, String> = [:]
                            usuario["email"] = email
                            usuario["nome"] = nome
                            
                            let chave = Base64().codificarStringBase64(texto: email)
                            
                            let usuarios = self.database.reference().child("usuarios")
                            usuarios.child(chave).setValue(usuario)
                            
                            print("Sucesso ao cadastrar usuário")
                            self.navigationController?.popViewController(animated: true)
                        }else{
                            print("Erro ao Cadastrar usuário")
                        }
                    })
                    
                }else{
                    print("Digite uma senha")
                }
            }else{
                print("Digite um email")
            }
        }else{
        print("Digite um nome")
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
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
