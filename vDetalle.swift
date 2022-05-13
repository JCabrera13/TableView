//
//  vDetalle.swift
//  TableView
//
//  Created by Karla Marquez on 5/12/22.
//

import Foundation
import UIKit

class vDetalle:UIViewController{
    
    @IBOutlet weak var lblDetalle: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    var indice:Int!

    override func viewDidLoad() {
        lblDetalle.text=lenguajes[indice].nombre
        imgLogo.image=lenguajes[indice].logo
    }
}
