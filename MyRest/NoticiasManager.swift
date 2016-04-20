//
//  NoticiasManager.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit

class NoticiasManager {
    class func getNoticias(result:(NSArray)->()){
        let url = NSURL(string: "https://www.dropbox.com/s/3ixkxttpgmpuhx2/noticias.json?dl=1")!
        
        NSURLConnection.jsonFromUrl(url, result: { (value) -> () in
            switch(value){
            case .Array(let array):
                result(array)
            default:
                print("Não é possível ler os dados do ficheiro -> noticias.json", terminator: "")
            }
        })
    }
}