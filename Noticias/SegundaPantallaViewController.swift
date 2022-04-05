//
//  SegundaPantallaViewController.swift
//  Noticias
//
//  Created by Mac11 on 01/04/22.
//

import UIKit
import WebKit

class SegundaPantallaViewController: UIViewController {

    @IBOutlet weak var web: WKWebView!
    var recibirUrl:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: recibirUrl ?? "") else { return}
        web.load(URLRequest(url: url))
    }
    

 
}
