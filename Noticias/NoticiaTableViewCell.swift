//
//  NoticiaTableViewCell.swift
//  Noticias
//
//  Created by Mac11 on 04/04/22.
//

import UIKit

class NoticiaTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFuente: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
