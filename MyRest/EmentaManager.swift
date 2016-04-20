//
//  EmentaManager.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit

class EmentaManager {
    class func getEmenta(result:(NSArray)->()){
        let url = NSURL(string: "https://www.dropbox.com/s/fbng2x6ykjovmtd/ementa.json?dl=1")!
        
        NSURLConnection.jsonFromUrl(url, result: { (value) -> () in
            switch(value){
            case .Array(let array):
                result(array)
            default:
                print("Não é possível ler os dados do ficheiro -> ementa.json", terminator: "")
            }
        })
    }
    
    

}
