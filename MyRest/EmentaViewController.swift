//
//  EmentaViewController.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit

class EmentaViewController:UIViewController{
    
    // Outlets
    @IBOutlet weak var descricao: UITextView!
    @IBOutlet weak var preco: UILabel!
    @IBOutlet weak var imagem: UIImageView!
    
    // Variables
    var ementa: NSDictionary? {
        didSet {
            // Update the view.
            self.loadDetailView()
        }
    }
    
    //Actions
    @IBAction func favoritesAction(sender: AnyObject) {
        if(DataStore.current.verificaFavorito(self.ementa!))
        {
            let alerta = UIAlertController(title: "Favorito", message: "Esse prato já pertençe à sua lista de favoritos!", preferredStyle: UIAlertControllerStyle.Alert)
            alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (sender) -> Void in}))
            self.presentViewController(alerta, animated: true, completion: nil)
            
        }
        else
        {
            DataStore.current.adicionaFavorito(self.ementa!)
            
        }
    }
    
    /*
    * ViewDidLoad method
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadDetailView();
    }
    
    /*
    * Method to load the detail view
    */
    func loadDetailView() {
        
        self.navigationItem.title = self.ementa?.valueForKeyPath("ementa.categoria.prato.nome") as? String
        let preco_str = self.ementa?.valueForKeyPath("ementa.categoria.prato.preco") as? String
        var preco = preco_str!.stringByReplacingOccurrencesOfString("Optional", withString: "")
        self.preco?.text = "€ \(preco) por pessoa"
        
        let ingredientes = self.ementa?.valueForKeyPath("ementa.categoria.prato.ingredientes.nome") as? String
        var ingred = ingredientes!.stringByReplacingOccurrencesOfString("Optional", withString: "")
        let descricao = self.ementa?.valueForKeyPath("ementa.categoria.prato.descricao") as? String
        var desc = descricao!.stringByReplacingOccurrencesOfString("Optional", withString: "")
        
        self.descricao?.text = " \(desc)\n\n Ingredientes: \(ingred)"
        
        //load image
        if let path = self.ementa?.valueForKeyPath("ementa.categoria.prato.imagens.path") as? NSString {
            var imgURL: NSURL = NSURL(string: path as String)!
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
                completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
                    if error == nil {
                        self.imagem?.image = UIImage(data: data!)
                    }
            })
        }else {
            self.imagem?.image = nil
        }
    }
}
