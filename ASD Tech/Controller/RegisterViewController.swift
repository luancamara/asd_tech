//
//  RegisterViewController.swift
//  ASD Tech
//
//  Created by Luan Camara on 17/06/21.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    let database = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var filhoNomeTextField: UITextField!
    @IBOutlet weak var filhoIdadeTextField: UITextField!
    @IBOutlet weak var filhoDiagnosticado: UISegmentedControl!
    @IBOutlet weak var responsavelNomeTextField: UITextField!
    @IBOutlet weak var responsavelIdadeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var senhaConfirmacaoTextField: UITextField!
    
    //MARK: - IBActions
    
    @IBAction func cadastreAction(_ sender: Any) {
        criaUsuario()
        self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
    }
    
    //MARK: - Métodos
    
    func criaUsuario() {
        if confirmaSenhaCadastro(senha: senhaTextField.text, confirmação: senhaConfirmacaoTextField.text) {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: senhaTextField.text!) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.salvaCadastro()
                    }
                }
            }
        } else {
            criaAlerta(titulo: "Senha inválida", mensagem: "Você digitou senhas diferentes, tente novamente")
            senhaTextField.text = ""
            senhaConfirmacaoTextField.text = ""
        }
    }
    
    func confirmaSenhaCadastro(senha: String?, confirmação senha2: String?) -> Bool {
        return senha == senha2
    }
    
    func criaAlerta(titulo: String, mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alerta.addAction(action)
        present(alerta, animated: true, completion: nil)
    }
    
    func salvaCadastro() {
        let dic = [
            Constants.FStore.nomeFilhoField: filhoNomeTextField.text!,
            Constants.FStore.idadeFilhoField: filhoIdadeTextField.text!,
            Constants.FStore.diagnosticoFilho: filhoDiagnosticado.titleForSegment(at: filhoDiagnosticado.selectedSegmentIndex)!,
            Constants.FStore.nomeResponsavelField: responsavelNomeTextField.text!,
            Constants.FStore.idadeResponsavelField: responsavelIdadeTextField.text!,
            Constants.FStore.emailField: emailTextField.text!,
            Constants.FStore.dateField: Date().timeIntervalSince1970
        ] as [String : Any]
        
        database.collection(Constants.FStore.collectionName).addDocument(data: dic) { error in
            print(Auth.auth().currentUser?.email)
            if error != nil {
                self.criaAlerta(titulo: "OPS", mensagem: "Não foi possivel salvar seu cadastro, tente novamente mais tarde")
            }
        }
    }
}
