//
//  Noticias.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import Foundation
import CoreData

class Noticias:NSManagedObject
{
    @NSManaged var id: Int
    @NSManaged var descricao: String
    @NSManaged var titulo: String
    @NSManaged var data: NSDate
    @NSManaged var imagem: Imagens
}