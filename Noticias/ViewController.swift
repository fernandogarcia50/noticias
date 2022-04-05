//
//  ViewController.swift
//  Noticias
//
//  Created by Mac11 on 30/03/22.
//

import UIKit
import SafariServices

struct Noticias:Codable {
    var articles:[Noticia]
}
struct Noticia: Codable {
    var title:String?
    var description:String?
    var urlToImage:String?
    var url:String?
    var source:Source?
    //var urlToImage:String?
    //var url:String?
}
struct Source: Codable {
    var name:String?
}
var articulosNoticias:[Noticia]=[]
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var noticias=[Noticia]()
    var Urlweb:String??
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articulosNoticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda=tablaNoticias.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! NoticiaTableViewCell
        celda.lblTitulo.text=articulosNoticias[indexPath.row].title
        celda.lblDescripcion.text=articulosNoticias[indexPath.row].description
        celda.lblFuente.text=articulosNoticias[indexPath.row].source?.name
        //crear imagen
        let urlImagen=articulosNoticias[indexPath.row].urlToImage
        celda.imagen.cargar(url: urlImagen ?? "")
        return celda
    }
    

    @IBOutlet weak var tablaNoticias: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //registrar celda
        tablaNoticias.register(UINib(nibName: "NoticiaTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        tablaNoticias.delegate=self
        tablaNoticias.dataSource=self
        let urlString="https://newsapi.org/v2/top-headlines?apiKey=021657abfddc4b6db731b1fca51cd3d0&country=mx"
        if let url=URL(string: urlString){
            if let data=try? Data(contentsOf: url){
                analizarJson(json: data)
            }
        }
        // Do any additional setup after loading the view.
    }
    func analizarJson(json:Data) {
        let decodificador=JSONDecoder()
        if let datosDecodificados=try? decodificador.decode(Noticias.self,from:json){
            //vaciar en array
            articulosNoticias=datosDecodificados.articles
            print("articulos de noticias son: \(datosDecodificados.articles.count)")
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(articulosNoticias[indexPath.row].url ?? "sin url")
        tablaNoticias.deselectRow(at: indexPath, animated: true)
        Urlweb=articulosNoticias[indexPath.row].url ?? ""
        let urlm=URL(string: (Urlweb ?? "") ?? "")!
        let vc = SFSafariViewController(url: urlm)
        present(vc, animated: true)
        //performSegue(withIdentifier: "navegar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="navegar"{
        let objDestino=segue.destination as! SegundaPantallaViewController
            objDestino.recibirUrl=Urlweb as? String
            
            
        }
    }
}
extension UIImageView{
    func cargar(url:String) {
        guard let url1 = URL(string: url) else { return }
        DispatchQueue.main.async {
            if let imagenData = try? Data(contentsOf: url1){
                if let imagenACargar=UIImage(data: imagenData){
                    self.image=imagenACargar
                }
                
            }
        }
 
    }
}

