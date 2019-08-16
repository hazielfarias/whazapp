//
//  AjustesViewController.swift
//  wHazApp
//
//  Created by Haziel Leite Farias on 14/08/19.
//  Copyright © 2019 Haziel. All rights reserved.
//

import UIKit
import FirebaseAuth

class AjustesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var auth: Auth!
    var imagePicker = UIImagePickerController()
    
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
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func alterarImagem(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagemRecuperada = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imagem.image = imagemRecuperada
        imagePicker.dismiss(animated: true, completion: nil)
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
