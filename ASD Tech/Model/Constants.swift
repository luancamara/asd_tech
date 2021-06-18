//
//  Constants.swift
//  ASD Tech
//
//  Created by Luan Camara on 17/06/21.
//

struct Constants {
    static let title = "TEA Tech"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCellTableViewCell"
    static let registerSegue = "registerToLoginScreen"
    static let loginSegue = "loginToLoginScreen"
    
    struct FStore {
        static let collectionName = "cadastros"
        static let nomeFilhoField = "nomeFilho"
        static let idadeFilhoField = "idadeFilho"
        static let diagnosticoFilho = "diagnosticoFilho"
        static let nomeResponsavelField = "nomeResponsavel"
        static let idadeResponsavelField = "idadeResponsavel"
        static let emailField = "emailResponsavel"
        static let dateField = "date"
    }
}
